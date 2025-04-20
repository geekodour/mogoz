+++
title = "Microcontrollers"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Electronics]({{< relref "20240630132114-electronics.md" >}}), [Computer Architecture]({{< relref "20221101201615-computer_architecture.md" >}}), [Robotics]({{< relref "20241130113714-robotics.md" >}}), [Maker Things / Hardware stuff]({{< relref "20240630192854-maker_things.md" >}})


## FAQ {#faq}


### STM32 vs ESP32 {#stm32-vs-esp32}

| Feature                      | STM32                                           | ESP32                                   |
|------------------------------|-------------------------------------------------|-----------------------------------------|
| Architecture                 | ARM Cortex-M (32-bit)                           | Tensilica Xtensa LX6 (dual-core 32-bit) |
| Manufacturer                 | STMicroelectronics                              | Espressif Systems                       |
| Primary Focus                | Processing power, peripheral variety            | Wireless connectivity (WiFi/BT)         |
| Wireless Capabilities        | Requires external modules                       | Built-in WiFi and Bluetooth             |
| Price Range                  | $1-15+ depending on model                       | $3-10 depending on module               |
| Power Efficiency             | Generally better for non-wireless applications  | Optimized for wireless with sleep modes |
| Development Environment      | STM32CubeIDE, Keil, IAR                         | Arduino IDE, ESP-IDF, PlatformIO        |
| Memory                       | Varies widely (8KB-2MB Flash, 2KB-640KB RAM)    | Typically 4MB Flash, 520KB SRAM         |
| Industrial Temperature Range | Most variants available                         | Limited options                         |
| Ecosystem Maturity           | Mature, extensive documentation                 | Newer but rapidly growing               |
| Use Case Sweet Spot          | Industrial control, precise timing applications | IoT, wireless networking projects       |


### What IDE to use? {#what-ide-to-use}

-   <https://arduino.github.io/arduino-cli/1.2/>
-   <https://platformio.org/>
-   Your favorite text editor
-   I don't like arduino IDE that much


### Terminologies/Jargons {#terminologies-jargons}


#### Microcontroller Architectures and Families {#microcontroller-architectures-and-families}

| Term       | Full Name                            | Description                                                                   |
|------------|--------------------------------------|-------------------------------------------------------------------------------|
| AVR        | Alf and Vegard's RISC processor      | 8-bit microcontroller architecture developed by Atmel (now Microchip)         |
| PIC        | Peripheral Interface Controller      | Family of microcontrollers made by Microchip Technology                       |
| ARM        | Advanced RISC Machines               | Company and processor architecture widely used in embedded systems            |
| STM32      | ST Microelectronics 32-bit           | Family of 32-bit ARM Cortex-M microcontrollers from ST Microelectronics       |
| ESP32      | Espressif Systems Platform 32        | Dual-core microcontroller with integrated Wi-Fi and Bluetooth                 |
| ESP8266    | Espressif Systems Platform 8266      | Low-cost Wi-Fi microchip with TCP/IP stack                                    |
| nRF52      | Nordic RF 52 series                  | Bluetooth Low Energy SoCs from Nordic Semiconductor                           |
| RISC-V     | Reduced Instruction Set Computer - V | Open-source instruction set architecture                                      |
| ATmega328P | Atmel mega 328P                      | 8-bit AVR microcontroller used in Arduino UNO                                 |
| ATtiny     | Atmel tiny                           | Smaller, simpler AVR microcontrollers with fewer features                     |
| RP2040     | Raspberry Pi Microcontroller         | Dual-core ARM Cortex-M0+ microcontroller developed by Raspberry Pi Foundation |


#### Architecture Types {#architecture-types}

See [Computer Architecture]({{< relref "20221101201615-computer_architecture.md" >}})

| Term             | Description                                                                                  |
|------------------|----------------------------------------------------------------------------------------------|
| RISC             | Reduced Instruction Set Computer - Simpler processor design with fewer instructions          |
| CISC             | Complex Instruction Set Computer - More complex processor with many specialized instructions |
| Harvard          | Architecture where program and data memory are separate                                      |
| Modified Harvard | Architecture that allows some controlled access between program and data memory              |
| Von Neumann      | Architecture where program and data share the same memory                                    |
| SoC              | System on Chip - Integrated circuit with all components of a computer or electronic system   |


#### Communication Protocols {#communication-protocols}

| Term       | Full Name                                               | Description                                                                   |
|------------|---------------------------------------------------------|-------------------------------------------------------------------------------|
| UART       | Universal Asynchronous Receiver/Transmitter             | Serial communication protocol using TX/RX lines                               |
| USART      | Universal Synchronous/Asynchronous Receiver/Transmitter | Enhanced UART with synchronous mode option                                    |
| I2C        | Inter-Integrated Circuit                                | Two-wire serial bus for connecting low-speed peripherals                      |
| TWI        | Two Wire Interface                                      | Another name for I2C, used primarily by Atmel                                 |
| SPI        | Serial Peripheral Interface                             | Synchronous serial communication for short-distance communication             |
| CAN        | Controller Area Network                                 | Robust vehicle bus standard for connecting microcontrollers                   |
| USB        | Universal Serial Bus                                    | Standard for connecting computers and electronic devices                      |
| BLE        | Bluetooth Low Energy                                    | Wireless technology for short-range communication with low power requirements |
| WiFi       | Wireless Fidelity                                       | Wireless networking technology based on IEEE 802.11 standards                 |
| MQTT       | Message Queuing Telemetry Transport                     | Lightweight messaging protocol for small sensors and mobile devices           |
| LoRa       | Long Range                                              | Long-range, low-power wireless platform                                       |
| RS-232/485 | Recommended Standard 232/485                            | Standard for serial communication transmission of data                        |


#### Peripherals and Hardware Features {#peripherals-and-hardware-features}

| Term  | Full Name                                   | Description                                                                                    |
|-------|---------------------------------------------|------------------------------------------------------------------------------------------------|
| GPIO  | General Purpose Input/Output                | Digital pins that can be configured as input or output                                         |
| ADC   | Analog-to-Digital Converter                 | Converts analog signals to digital values                                                      |
| DAC   | Digital-to-Analog Converter                 | Converts digital values to analog signals                                                      |
| PWM   | Pulse Width Modulation                      | Technique for getting analog results with digital means                                        |
| JTAG  | Joint Test Action Group                     | Standard interface for debugging and programming microcontrollers                              |
| SWD   | Serial Wire Debug                           | Two-pin alternative to JTAG for debugging ARM processors                                       |
| PIO   | Programmable Input/Output                   | Flexible I/O system on the RP2040 (Raspberry Pi Pico)                                          |
| Timer | Timer/Counter                               | Hardware module that counts clock cycles for timing operations                                 |
| RTC   | Real-Time Clock                             | Keeps track of current time                                                                    |
| WDT   | Watchdog Timer                              | Timer that resets the system if the program hangs                                              |
| FPU   | Floating Point Unit                         | Hardware that performs operations on floating point numbers                                    |
| DSP   | Digital Signal Processor                    | Specialized processor for digital signal processing operations                                 |
| UART  | Universal Asynchronous Receiver/Transmitter | Hardware for serial communication                                                              |
| PLL   | Phase-Locked Loop                           | Circuit that generates an output signal whose phase is related to the phase of an input signal |


#### Development Approaches and Environments {#development-approaches-and-environments}

| Term | Full Name                  | Description                                               |
|------|----------------------------|-----------------------------------------------------------|
| HAL  | Hardware Abstraction Layer | Software layer that bridges hardware and operating system |


#### Specific Development Boards {#specific-development-boards}

| Term              | Description                                                |
|-------------------|------------------------------------------------------------|
| Arduino UNO       | Popular development board based on ATmega328P              |
| Arduino Nano      | Compact version of the Arduino UNO                         |
| Raspberry Pi Pico | Development board based on RP2040 microcontroller          |
| ESP32-DevKit      | Development board for the ESP32 microcontroller            |
| NodeMCU           | Development board based on ESP8266                         |
| STM32 Nucleo      | Development board for STM32 microcontrollers               |
| BBC micro:bit     | Educational development board based on nRF51822            |
| Teensy            | Development board based on ARM Cortex-M4                   |
| Adafruit Feather  | Family of development boards with standardized form factor |
| SparkFun RedBoard | Arduino-compatible development board                       |


#### Tools and Equipment {#tools-and-equipment}

| Term           | Full Name             | Description                                                    |
|----------------|-----------------------|----------------------------------------------------------------|
| Oscilloscope   | -                     | Instrument that displays signal voltages as a function of time |
| Logic Analyzer | -                     | Device that captures and displays digital signals              |
| Multimeter     | -                     | Instrument that measures voltage, current, and resistance      |
| Bus Pirate     | -                     | Universal bus interface tool for debugging                     |
| UART-to-USB    | -                     | Bridge for connecting UART interfaces to USB                   |
| ST-Link        | -                     | Programming and debugging interface for STM32 microcontrollers |
| J-Link         | -                     | Debug probe for ARM cores                                      |
| OpenOCD        | Open On-Chip Debugger | Open-source tool for on-chip debugging, in-system programming  |


### History &amp; Lineage of Microcontrollers {#history-and-lineage-of-microcontrollers}


#### Popular Microcontroller Families {#popular-microcontroller-families}

| Family       | Year Introduced | Architecture        | Notable Examples                 | Bit Width       | Key Features              | Community/Support               | Best For                          | Things to Be Aware Of                          |
|--------------|-----------------|---------------------|----------------------------------|-----------------|---------------------------|---------------------------------|-----------------------------------|------------------------------------------------|
| AVR          | 1996            | Harvard             | ATmega328P (Arduino UNO, 2005)   | 8-bit           | - Simple architecture     | Very large (Arduino)            | Beginners                         | - Limited memory                               |
|              |                 |                     | ATtiny Series (1999)             |                 | - Excellent documentation | Many tutorials                  | Battery-powered                   | - Lower processing power                       |
|              |                 |                     |                                  |                 | - Low power modes         |                                 | Simple projects                   | - Slowly being phased out                      |
|              |                 |                     |                                  |                 | - Direct memory access    |                                 |                                   |                                                |
| PIC          | 1976            | Harvard             | PIC16F (1993)                    | 8-bit to 32-bit | - Wide variety            | Strong but smaller than Arduino | Industrial applications           | - Steeper learning curve                       |
|              |                 |                     | PIC18F (2000)                    |                 | - Industrial reliability  |                                 | Long-term projects                | - Less hobbyist-friendly IDE                   |
|              |                 |                     | PIC32 (2007)                     |                 | - Low power               |                                 |                                   | - Often requires paid tools                    |
|              |                 |                     |                                  |                 | - Many peripherals        |                                 |                                   |                                                |
| ARM Cortex-M | 2004            | Modified Harvard    | STM32 (2007)                     | 32-bit          | - High performance        | Growing rapidly                 | Complex projects                  | - More complex                                 |
|              |                 |                     | NXP LPC (2003)                   |                 | - Rich peripheral set     | Good documentation              | Performance-critical applications | - Steeper learning curve                       |
|              |                 |                     | SAM (2006)                       |                 | - Advanced timers         |                                 |                                   | - More difficult debugging                     |
|              |                 |                     | RP2040 (Pi Pico, 2021)           |                 | - DMA controllers         |                                 |                                   |                                                |
| nRF52        | 2015            | Modified Harvard    | nRF52832 (2015)                  | 32-bit          | - Built-in Bluetooth 5.x  | Good Nordic support             | Wearables, Bluetooth IoT          | BLE complexity, More expensive than basic MCUs |
|              |                 |                     | nRF52840 (2017), nRF52833 (2019) |                 | - Ultra-low power         |                                 |                                   |                                                |
|              |                 |                     |                                  |                 | - ARM Cortex-M4F          |                                 |                                   |                                                |
| ESP          | 2014            | Modified Harvard    | ESP8266 (2014)                   | 32-bit          | - Built-in WiFi/BT        | Large and active                | IoT projects                      | - Higher power consumption                     |
|              |                 |                     | ESP32 (2016)                     |                 | - Dual-core (ESP32)       | Many libraries                  | Wireless connectivity             | - Documentation can be inconsistent            |
|              |                 |                     | ESP32-C3 (2020)                  |                 | - Low cost                |                                 |                                   | - Complex WiFi stack                           |
|              |                 |                     |                                  |                 | - Deep sleep modes        |                                 |                                   |                                                |
| MSP430       | 2000            | Von Neumann         | MSP430G2 (2010)                  | 16-bit          | - Ultra-low power         | Texas Instruments support       | Battery/energy harvesting         | - Smaller community                            |
|              |                 |                     | MSP430FR (2014)                  |                 | - FRAM options            | Energia platform                | Low-power sensing                 | - Fewer ready-made libraries                   |
|              |                 |                     |                                  |                 | - Analog peripherals      |                                 |                                   | - Limited processing power                     |
|              |                 |                     |                                  |                 | - Simple instruction set  |                                 |                                   |                                                |
| RISC-V       | 2010            | Harvard/Von Neumann | GD32V (2019)                     | 32-bit/64-bit   | - Open architecture       | Growing but still smaller       | Future-proofing                   | - Still emerging ecosystem                     |
|              |                 |                     | ESP32-C3 (2020)                  |                 | - Growing ecosystem       |                                 | Open-source projects              | - Fewer off-the-shelf examples                 |
|              |                 |                     | SiFive FE310 (2017)              |                 | - Modern design           |                                 |                                   | - Some debugging challenges                    |
|              |                 |                     |                                  |                 | - Customizable            |                                 |                                   |                                                |
| 8051         | 1980            | Harvard             | AT89S52 (1995)                   | 8-bit           | - Simple architecture     | Legacy resources                | Learning computer architecture    | - Outdated architecture                        |
|              |                 |                     | STC microcontrollers (2005)      |                 | - Historical significance | Industrial support              | Simple control systems            | - Limited memory addressing                    |
|              |                 |                     |                                  |                 | - Still used in industry  |                                 |                                   | - Fewer modern tools                           |
|              |                 |                     |                                  |                 | - Highly deterministic    |                                 |                                   |                                                |


#### Historical Timeline &amp; Significance {#historical-timeline-and-significance}

| Era   | Significant MCUs | Year      | Impact                            | Legacy                                                 |
|-------|------------------|-----------|-----------------------------------|--------------------------------------------------------|
| 1970s | Intel 8048       | 1976      | First single-chip microcontroller | Set foundation for embedded computing                  |
|       | Intel 8051       | 1980      | First widely adopted MCU          | 8051 architecture still influences many modern designs |
| 1980s | Motorola 68HC11  | 1984      | Advanced integrated peripherals   | Established MCU programming paradigms                  |
|       | PIC16C           | 1985      | RISC architecture for MCUs        | Pioneered flash-based microcontrollers                 |
| 1990s | AVR series       | 1996      | Flash memory + RISC               | AVR became foundation for Arduino                      |
|       | PIC16F           | 1993      | Low-cost flash MCUs               | Brought MCUs to hobbyists                              |
|       | 8051 derivatives | 1995+     | Widespread adoption               | Enabled early DIY electronics                          |
| 2000s | ARM7TDMI         | 2001      | 32-bit becomes accessible         | ARM dominance begins                                   |
|       | Arduino launch   | 2005      | AVR-based development board       | Hobbyist revolution                                    |
|       | ARM Cortex-M3    | 2004      | Modern 32-bit architecture        | Arduino ecosystem transformed accessibility            |
| 2010s | ARM Cortex-M4    | 2010      | DSP + FPU capabilities            | Advanced signal processing becomes accessible          |
|       | ESP8266          | 2014      | $2 WiFi MCU                       | IoT revolution                                         |
|       | ESP32            | 2016      | Dual-core WiFi+BT                 | WiFi integration becomes standard                      |
|       | STM32F7/H7       | 2015-2016 | High-performance MCUs             | 32-bit becomes affordable for all applications         |
| 2020s | RP2040 (Pi Pico) | 2021      | $4 dual-core with PIO             | Open architectures gain traction                       |
|       | ESP32-C3         | 2020      | RISC-V based WiFi/BT              | RISC-V enters mainstream                               |
|       | ESP32-S3         | 2021      | AI acceleration                   | AI capabilities in MCUs                                |


## How to study microcontrollers? {#how-to-study-microcontrollers}


### Other notes {#other-notes}


#### 8-bit vs 32-bit {#8-bit-vs-32-bit}

Pro 8-bit: Good for learning fundamentals (AVR/Arduino, PIC)
Pro 32-bit: Not harder than 8-bit, more future-proof, competitive pricing
Industry view: 8-bit primarily for high-volume cost-sensitive products


#### Application-Specific Options {#application-specific-options}

Bluetooth: Nordic (best documentation), alternatives: TI, STM32WB, Silabs
WiFi: ESP32 (largest hobbyist community)
General purpose: STM32 (industry standard)
Recommendation: Choose based on project requirements, not preference


#### Development Methods {#development-methods}

Bare-metal: Best for fundamental understanding (no Arduino framework)
Framework-based: Easier entry but may hide important concepts
Best practice: Start with framework, progress to bare-metal


#### Skills Progression {#skills-progression}

Basic peripherals: GPIO, Interrupts, Timers, ADC, PWM
Communication protocols: UART, I2C, SPI
Advanced topics: RTOS (only after mastering basics)


### Learning Roadmap {#learning-roadmap}

> this is based on the hardware i currently have in lab.


#### Phase 1: Arduino Nano (8-bit AVR) - Fundamentals (1 month) {#phase-1-arduino-nano--8-bit-avr--fundamentals--1-month}

<!--list-separator-->

-  Week 1-2: AVR Basics

    -   Setup development environment (Arduino IDE → PlatformIO → AVR-GCC)
    -   Direct register manipulation (no Arduino framework)
    -   GPIO control, timers, and interrupts

    <!--list-separator-->

    -  Project: Electronic Dice

        -   Roll electronic dice using a button press
        -   Display results on LEDs in binary pattern
        -   Use timer interrupts for button debouncing
        -   Implement true random number generation using analog noise

<!--list-separator-->

-  Week 3-4: Communication &amp; Peripherals

    -   UART, SPI, and I²C implementation from scratch
    -   ADC and sensor integration
    -   Power management and sleep modes

    <!--list-separator-->

    -  Project: Weather Monitor

        -   Connect temperature/humidity sensor via I²C
        -   Implement custom low-level I²C driver (no Wire library)
        -   Use sleep modes for power efficiency
        -   Create serial protocol for data reporting


#### Phase 2: Raspberry Pi Pico (32-bit ARM) - Modern MCU (1-2 months) {#phase-2-raspberry-pi-pico--32-bit-arm--modern-mcu--1-2-months}

<!--list-separator-->

-  Week 1-2: ARM Architecture

    -   Setup Pico SDK environment (C/C++)
    -   Understand ARM interrupt model
    -   Multicore programming basics

    <!--list-separator-->

    -  Project: Digital Synthesizer

        -   Generate waveforms using PWM and DMA
        -   Use second core for effects processing
        -   Implement MIDI input over USB
        -   Create modular architecture for different sound modules

<!--list-separator-->

-  Week 3-6: Advanced Peripherals

    -   PIO (Programmable I/O) programming
    -   DMA for efficient data transfers
    -   USB interface implementation

    <!--list-separator-->

    -  Project: Logic Analyzer

        -   Use PIO to capture digital signals at high speed
        -   Implement circular buffer with DMA
        -   Create USB interface for PC visualization
        -   Add protocol decoder for common interfaces (I²C, SPI)


#### Phase 3: ESP32 (32-bit Xtensa) - Connectivity &amp; RTOS (2 months) {#phase-3-esp32--32-bit-xtensa--connectivity-and-rtos--2-months}

<!--list-separator-->

-  Week 1-2: Wireless &amp; ESP-IDF

    -   Move from Arduino framework to ESP-IDF
    -   Wi-Fi and BLE configuration
    -   Web server and RESTful API development

    <!--list-separator-->

    -  Project: Home Environmental Controller

        -   Monitor multiple environmental factors
        -   Create elegant web interface
        -   Implement secure API for remote control
        -   Use BLE for local control from smartphone

<!--list-separator-->

-  Week 3-4: Zephyr &amp; Task Management

    -   Zephyr tasks, queues, and semaphores
    -   Memory management in multi-threaded environments
    -   Power optimization for battery operation

    <!--list-separator-->

    -  Project: Wireless Sensor Network

        -   Create mesh network of ESP32 devices
        -   Implement efficient sleep/wake cycles
        -   Use MQTT for cloud connectivity
        -   Visualize data with dashboard

<!--list-separator-->

-  Week 5-8: Advanced Integration

    <!--list-separator-->

    -  Capstone Project: Automated Garden System

        -   Arduino Nano: Soil sensors and pump control (low-power sentinel)
        -   Raspberry Pi Pico: Camera processing for plant health analysis
        -   ESP32: Connectivity hub and user interface
        -   Custom PCB design for permanent installation
        -   Smartphone app for monitoring and control
