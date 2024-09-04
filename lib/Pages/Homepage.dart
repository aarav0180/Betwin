import 'package:betwin/Pages/Joinroom.dart';
import 'package:betwin/Pages/createRoom.dart';
import 'package:betwin/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:betwin/Widgets/custom_button.dart';
import 'package:web3modal_flutter/services/w3m_service/w3m_service.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

import '../Widgets/service_widget.dart';

class Homepage extends StatefulWidget {
  static String routeName = '/Homepage';
  const Homepage({super.key});

  void createRoom(BuildContext context){
    Navigator.pushNamed(context, CreateRoom.routeName);
  }

  void joinRoom(BuildContext context){
    Navigator.pushNamed(context, JoinRoom.routeName);
  }

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //wallet connect
  late W3MService _w3mService;
  @override
  void initState() {
    super.initState();
    initializestate();
  }

  void initializestate() async {

    //adding sepolia chain
    W3MChainPresets.chains.putIfAbsent('11155111', () => _sepoliaChain);

    _w3mService = W3MService(
      projectId: '8725de431cce7dd15b81ea92bbac49b9',
      metadata: const PairingMetadata(
        name: 'Web3Modal Flutter Example',
        description: 'Web3Modal Flutter Example',
        url: 'https://www.walletconnect.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
        redirect: Redirect(
          native: 'w3m://',
          universal: 'https://www.walletconnect.com',
        ),
      ),
    );
    await _w3mService.init();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome Aboard",
                          style: AppWidget.boldTextfieldStyle()),
                      SizedBox(height: 20,),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

        body: Container(
          margin: EdgeInsets.only(left:10, right: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Responsive(
              child: Column(
              
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(12)),
                        child: W3MAccountButton(service: _w3mService),
                      ),
                      SizedBox(width: 2,),
                      Container(
                        decoration: BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(12)),
                        child: W3MNetworkSelectButton(service: _w3mService),
                      ),
              
                    ],
                  ),
                  SizedBox(height: 50,),
              
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(18)),
                    child: Column(
                      children: [
                        Container(
                          //padding: EdgeInsets.all(13),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(13),
                            child: Image.asset('images/tictactoe.jpg', fit: BoxFit.cover,)),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(onTap: (){}, text: "Create Game"),
                            CustomButton(onTap: (){}, text: "Join Game"),
                          ],
                        ),
                        SizedBox(height: 20,),
                      ],
                    ),
              
                  ),
              
                  
                  SizedBox(height: 60,),
              
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(12)),
                    child: W3MConnectWalletButton(service: _w3mService),
                  ),
              
              
              
              
                ],
              ),
            )
        ),

    );
  }
}

//adding sepolia chian
const _chainId = "11155111";

final _sepoliaChain = W3MChainInfo(
  chainName: 'Sepolia',
  namespace: 'eip155:$_chainId',
  chainId: _chainId,
  tokenName: 'ETH',
  rpcUrl: 'https://rpc.sepolia.org/',
  blockExplorer: W3MBlockExplorer(
    name: 'Sepolia Explorer',
    url: 'https://sepolia.etherscan.io/',
  ),
);


