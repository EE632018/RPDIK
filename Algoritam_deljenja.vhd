library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Algoritam_deljenja is
  generic(WIDTH:positive:=8);
  Port ( -- Clocking and reset interface
        clk:in std_logic;
        reset:in std_logic;
        --Input data interface
        a_in: in std_logic_vector(WIDTH-1 downto 0);
        b_in: in std_logic_vector(WIDTH-1 downto 0);
        -- Output interface
        q:out std_logic_vector(WIDTH-1 downto 0);
        r:out std_logic_vector(WIDTH-1 downto 0);
        -- Command interface]
        start:in std_logic;
        --Status intefrace
        ready:out std_logic);
end Algoritam_deljenja;

architecture Behavioral of Algoritam_deljenja is
-- Additional signals 
signal op1,op2,a_next,b_next,sub,adder,q_s,r_s:std_logic_vector(WIDTH-1 downto 0);
-- States of FSM diagram
type state_type is (idle,bigger,divide,result,cuvanje,konacni_res);
signal state_reg,state_next:state_type;

begin

    -- control path state register
        process(clk,reset)
        begin
            if(reset='1')then
                state_reg<=idle;
            elsif(rising_edge(clk))then
               state_reg<=state_next;     
            end if;
       end process;
       
    --control path: next state/output logic
        process(state_reg,start,a_in,b_in)is
        begin
            case state_reg is
                when idle=>
                    if(start = '1')then
                        state_next<=bigger; 
                    end if;
                when bigger=>
                     if (a_in>b_in)then
                        state_next<=divide;
                     else
                        state_next<=divide;
                     end if;
                when divide=>
                    if(op1>op2)then
                        state_next<=cuvanje;
                    else
                     state_next<=result;
                     end if; 
                 when cuvanje=>
                    state_next<=divide;    
                when result=>
                    state_next<=konacni_res;                 
                when konacni_res=>
                    state_next<=idle;    
            end case;    
        end process;        
        
        -- control path: output logic
        ready<= '1' when state_reg=idle else
                '0';
                
        --data path:routing mux
        process(state_reg,a_in,b_in,a_next,b_next)is 
        begin
            case state_reg is
                when idle=>
                    a_next<=a_in;
                    b_next<=b_in;
                    q_s<=(others=>'0');
                    r_s<=(others=> '0');
                when bigger=>
                    if(a_next>b_next) then
                        op1<=a_next;
                        op2<=b_next;
                    else 
                        op1<=b_next;
                        op2<=a_next;
                    end if;        
                when divide=>
                    op1<=sub;
                    q_s<=adder;
                when cuvanje => 
                    op1<=op1;
                    op2<=op2;    
                when result=>
                    r_s<=op1; 
                when konacni_res=>    
                    r<=r_s;
                    q<=q_s;  
            end case;        
        end process;
                
        -- Addiotional functions of resolving dividing to numbers
        adder<= std_logic_vector(TO_UNSIGNED(1,WIDTH) + unsigned(q_s));
        sub<= std_logic_vector(unsigned(op1) - unsigned(op2));   
end Behavioral;
