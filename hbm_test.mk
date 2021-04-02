.PHONY: run dramsim3.txt

run: dramsim3.txt
BSG_MANCYORE_DIR := ../../../bsg_manycore
BLOOD-GRAPH-GEN  := $(BSG_MANCYORE_DIR)/software/py/dramsim3_blood_graph.py

PYTHON		:= $(shell which python3)
TRACE-GENERATOR := scripts/manycore_l2_trace_gen.py
CONFIG		:= configs/HBM2_8Gb_x128_8bgX8ba_ps.ini
CYCLES		:= 100000
DRAMSIM3        := build/dramsim3main
trace.tr: $(TRACE-GENERATOR)
	$(PYTHON) $(TRACE-GENERATOR) > $@

dramsim3.txt: trace.tr
	./$(DRAMSIM3) $(CONFIG) -c $(CYCLES) -t $(filter %.tr,$^)

blood.png: dramsim3.txt
	$(PYTHON) $(BLOOD-GRAPH-GEN) blood_graph_ch0.log $@
