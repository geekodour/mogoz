+++
title = "wireless cracking"
author = ["Hrishikesh Barman"]
draft = false
+++

tags
: [Wireless]({{< relref "20221101184406-wireless.md" >}})


## Using aircrack {#using-aircrack}

```bash
iwconfig
airmon-ng check kill
sudo airmon-ng start wlan0 # this will move your interface into monitor mode and rename it to wlan0mon
sudo airmon-ng stop wlan0mon # rename back to wlan0
```

```nil
(wlan.fc.type == 0) && (wlan.fc.type_subtype ==  0x0c)
(wlan.fc.type eq 0) && (wlan.fc.type_subtype eq 0x0c)
(wlan.fc.type eq 0) && (wlan.fc.type_subtype eq 12)
7e:9f:1b:05:00:97
7e:9f:1b:05:00:97
```

```nil
Frame 457: 150 bytes on wire (1200 bits), 150 bytes captured (1200 bits) on interface wlan0mon, id 0
    Section number: 1
    Interface id: 0 (wlan0mon)
    Encapsulation type: IEEE 802.11 plus radiotap radio header (23)
    Arrival Time: Dec  3, 2022 11:13:01.986132968 IST
    [Time shift for this packet: 0.000000000 seconds]
    Epoch Time: 1670046181.986132968 seconds
    [Time delta from previous captured frame: 0.416672776 seconds]
    [Time delta from previous displayed frame: 0.416672776 seconds]
    [Time since reference or first frame: 84.732840618 seconds]
    Frame Number: 457
    Frame Length: 150 bytes (1200 bits)
    Capture Length: 150 bytes (1200 bits)
    [Frame is marked: False]
    [Frame is ignored: False]
    [Protocols in frame: radiotap:wlan_radio:wlan]
Radiotap Header v0, Length 54
    Header revision: 0
    Header pad: 0
    Header length: 54
    Present flags
    MAC timestamp: 91778742
    Flags: 0x10
    Data Rate: 1.0 Mb/s
    Channel frequency: 2457 [BG 10]
    Channel flags: 0x00a0, Complementary Code Keying (CCK), 2 GHz spectrum
    Antenna signal: -46 dBm
    RX flags: 0x0000
    timestamp information
    Antenna signal: -46 dBm
    Antenna: 0
802.11 radio information
    PHY type: 802.11b (HR/DSSS) (4)
    Short preamble: False
    Data rate: 1.0 Mb/s
    Channel: 10
    Frequency: 2457MHz
    Signal strength (dBm): -46 dBm
    TSF timestamp: 91778742
    [Duration: 960µs]
IEEE 802.11 Probe Request, Flags: ....R...C
    Type/Subtype: Probe Request (0x0004)
    Frame Control Field: 0x4008
    .000 0001 0011 1010 = Duration: 314 microseconds
    Receiver address: Ubiquiti_e7:2a:89 (18:e8:29:e7:2a:89)
    Destination address: Ubiquiti_e7:2a:89 (18:e8:29:e7:2a:89)
    Transmitter address: 7e:9f:1b:05:00:97 (7e:9f:1b:05:00:97)
    Source address: 7e:9f:1b:05:00:97 (7e:9f:1b:05:00:97)
    BSS Id: Ubiquiti_e7:2a:89 (18:e8:29:e7:2a:89)
    .... .... .... 0000 = Fragment number: 0
    1000 1011 0010 .... = Sequence number: 2226
    Frame check sequence: 0x0b5492d5 [unverified]
    [FCS Status: Unverified]
IEEE 802.11 Wireless Management
    Tagged parameters (68 bytes)
        Tag: SSID parameter set: "YASH222"
        Tag: Supported Rates 1(B), 2(B), 5.5(B), 11(B), 6(B), 9, 12(B), 18, [Mbit/sec]
        Tag: Extended Supported Rates 24(B), 36, 48, 54, [Mbit/sec]
        Tag: DS Parameter set: Current Channel: 11
        Tag: HT Capabilities (802.11n D1.10)
        Tag: Extended Capabilities (10 octets)
```
