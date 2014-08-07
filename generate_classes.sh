# !/bin/bash

# Call this shell script from the terminal: ./generate_classes.sh
MOMC_NO_INVERSE_RELATIONSHIP_WARNINGS=YES \
	mogenerator --template-var arc=true \
  -m ./Pod/Assets/EEEEventKitBufferModel.xcdatamodeld/EEEEventKitBufferModel.xcdatamodel \
  --machine-dir ./Pod/Classes/Model/Entities/Abstract \
  --human-dir ./Pod/Classes/Model/Entities