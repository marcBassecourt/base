Entity ip_telem_tb is
End entity;
Architecture bench of ip_telem_tb is
	Signal Tclk : std_logic := ?0?;
	Signal Trst : std_logic;
	signal TA,TB,TOUT : std_logic_vector(3 downto 0);
	signal Done : boolean := False;

Begin
	-- instanciation du composant à tester
	UUT: entity work.design port map (
	A => TA, B => TB,
	OUT => TOUT,
	clk => Tclk, rst => Trst);
-- Génération d?une horloge
Tclk <= ?0? when Done else not Tclk after 50 ns;
-- Génération d?un reset au début
Trst <= ?1?, ?0? after 5 ns;Stimuli_&_verification: process
Begin
TA <= ?0000?;
TB <= ?0000?;
wait for 5 NS;
assert TOUT = ?0000? report ?erreur? severity warning;
wait for 5 NS;
TA <= ?1111?;
wait for 5 NS;
assert TOUT = ?1111? report ?erreur? severity warning;
wait for 5 NS;
TA <= ?0101?;
TB <= ?1010?;
wait for 5 NS;
assert TOUT = ?1010? report ?erreur? severity warning;
Done <= True;
wait;
end process;
End architecture;