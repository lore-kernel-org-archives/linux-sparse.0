From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: Bogus 'Initializer entry defined twice' warnings
Date: Wed, 05 Nov 2014 08:44:46 +0100
Message-ID: <5459D56E.3080704@xs4all.nl>
References: <5400357A.5050705@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lb2-smtp-cloud2.xs4all.net ([194.109.24.25]:60732 "EHLO
	lb2-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753572AbaKEHow (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 5 Nov 2014 02:44:52 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by tschai.lan (Postfix) with ESMTPSA id 83F2E2A0432
	for <linux-sparse@vger.kernel.org>; Wed,  5 Nov 2014 08:44:46 +0100 (CET)
In-Reply-To: <5400357A.5050705@xs4all.nl>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Ping!

This is still failing (tested with the latest sparse v0.5.0-35-gc1c3f96
from git://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git).

I'd really like to get rid of these spurious sparse warnings.

Regards,

	Hans

On 08/29/2014 10:10 AM, Hans Verkuil wrote:
> The following test source (based on drivers/media/pci/cx88/cx88-cards.c from
> the kernel) gives these sparse warnings:
> 
> cards4.c:447:36: warning: Initializer entry defined twice
> cards4.c:449:19:   also defined here
> cards4.c:456:36: warning: Initializer entry defined twice
> cards4.c:458:19:   also defined here
> cards4.c:611:36: warning: Initializer entry defined twice
> cards4.c:613:19:   also defined here
> cards4.c:620:36: warning: Initializer entry defined twice
> cards4.c:622:19:   also defined here
> cards4.c:629:36: warning: Initializer entry defined twice
> cards4.c:631:20:   also defined here
> cards4.c:638:37: warning: Initializer entry defined twice
> cards4.c:640:20:   also defined here
> cards4.c:611:36: warning: Initializer entry defined twice
> cards4.c:613:19:   also defined here
> cards4.c:620:36: warning: Initializer entry defined twice
> cards4.c:622:19:   also defined here
> cards4.c:629:36: warning: Initializer entry defined twice
> cards4.c:631:20:   also defined here
> cards4.c:638:37: warning: Initializer entry defined twice
> cards4.c:640:20:   also defined here
> cards4.c:675:26: warning: Initializer entry defined twice
> cards4.c:676:26:   also defined here
> cards4.c:727:37: warning: Initializer entry defined twice
> cards4.c:729:20:   also defined here
> cards4.c:736:36: warning: Initializer entry defined twice
> cards4.c:738:20:   also defined here
> cards4.c:824:36: warning: Initializer entry defined twice
> cards4.c:826:20:   also defined here
> cards4.c:815:36: warning: Initializer entry defined twice
> cards4.c:817:20:   also defined here
> cards4.c:824:36: warning: Initializer entry defined twice
> cards4.c:826:20:   also defined here
> cards4.c:815:36: warning: Initializer entry defined twice
> cards4.c:817:20:   also defined here
> 
> These warnings are patently false, and removing a single entry
> (say the first one) will result in a set of warnings for different
> lines. Frankly, it looks what would happen if there is a wrong
> hash table lookup.
> 
> I am using the latest sparse code from
> git://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git.
> 
> 
> Regards,
> 
> 	Hans
> 
> ------------------- cut here ------------------------
> #define CX88_BOARD_UNKNOWN                  0
> #define CX88_BOARD_HAUPPAUGE                1
> #define CX88_BOARD_GDI                      2
> #define CX88_BOARD_PIXELVIEW                3
> #define CX88_BOARD_ATI_WONDER_PRO           4
> #define CX88_BOARD_WINFAST2000XP_EXPERT     5
> #define CX88_BOARD_AVERTV_STUDIO_303        6
> #define CX88_BOARD_MSI_TVANYWHERE_MASTER    7
> #define CX88_BOARD_WINFAST_DV2000           8
> #define CX88_BOARD_LEADTEK_PVR2000          9
> #define CX88_BOARD_IODATA_GVVCP3PCI        10
> #define CX88_BOARD_PROLINK_PLAYTVPVR       11
> #define CX88_BOARD_ASUS_PVR_416            12
> #define CX88_BOARD_MSI_TVANYWHERE          13
> #define CX88_BOARD_KWORLD_DVB_T            14
> #define CX88_BOARD_DVICO_FUSIONHDTV_DVB_T1 15
> #define CX88_BOARD_KWORLD_LTV883           16
> #define CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q  17
> #define CX88_BOARD_HAUPPAUGE_DVB_T1        18
> #define CX88_BOARD_CONEXANT_DVB_T1         19
> #define CX88_BOARD_PROVIDEO_PV259          20
> #define CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_PLUS 21
> #define CX88_BOARD_PCHDTV_HD3000           22
> #define CX88_BOARD_DNTV_LIVE_DVB_T         23
> #define CX88_BOARD_HAUPPAUGE_ROSLYN        24
> #define CX88_BOARD_DIGITALLOGIC_MEC        25
> #define CX88_BOARD_IODATA_GVBCTV7E         26
> #define CX88_BOARD_PIXELVIEW_PLAYTV_ULTRA_PRO 27
> #define CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_T  28
> #define CX88_BOARD_ADSTECH_DVB_T_PCI          29
> #define CX88_BOARD_TERRATEC_CINERGY_1400_DVB_T1  30
> #define CX88_BOARD_DVICO_FUSIONHDTV_5_GOLD 31
> #define CX88_BOARD_AVERMEDIA_ULTRATV_MC_550 32
> #define CX88_BOARD_KWORLD_VSTREAM_EXPERT_DVD 33
> #define CX88_BOARD_ATI_HDTVWONDER          34
> #define CX88_BOARD_WINFAST_DTV1000         35
> #define CX88_BOARD_AVERTV_303              36
> #define CX88_BOARD_HAUPPAUGE_NOVASPLUS_S1  37
> #define CX88_BOARD_HAUPPAUGE_NOVASE2_S1    38
> #define CX88_BOARD_KWORLD_DVBS_100         39
> #define CX88_BOARD_HAUPPAUGE_HVR1100       40
> #define CX88_BOARD_HAUPPAUGE_HVR1100LP     41
> #define CX88_BOARD_DNTV_LIVE_DVB_T_PRO     42
> #define CX88_BOARD_KWORLD_DVB_T_CX22702    43
> #define CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_DUAL 44
> #define CX88_BOARD_KWORLD_HARDWARE_MPEG_TV_XPERT 45
> #define CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_HYBRID 46
> #define CX88_BOARD_PCHDTV_HD5500           47
> #define CX88_BOARD_KWORLD_MCE200_DELUXE    48
> #define CX88_BOARD_PIXELVIEW_PLAYTV_P7000  49
> #define CX88_BOARD_NPGTECH_REALTV_TOP10FM  50
> #define CX88_BOARD_WINFAST_DTV2000H        51
> #define CX88_BOARD_GENIATECH_DVBS          52
> #define CX88_BOARD_HAUPPAUGE_HVR3000       53
> #define CX88_BOARD_NORWOOD_MICRO           54
> #define CX88_BOARD_TE_DTV_250_OEM_SWANN    55
> #define CX88_BOARD_HAUPPAUGE_HVR1300       56
> #define CX88_BOARD_ADSTECH_PTV_390         57
> #define CX88_BOARD_PINNACLE_PCTV_HD_800i   58
> #define CX88_BOARD_DVICO_FUSIONHDTV_5_PCI_NANO 59
> #define CX88_BOARD_PINNACLE_HYBRID_PCTV    60
> #define CX88_BOARD_WINFAST_TV2000_XP_GLOBAL 61
> #define CX88_BOARD_POWERCOLOR_REAL_ANGEL   62
> #define CX88_BOARD_GENIATECH_X8000_MT      63
> #define CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_PRO 64
> #define CX88_BOARD_DVICO_FUSIONHDTV_7_GOLD 65
> #define CX88_BOARD_PROLINK_PV_8000GT       66
> #define CX88_BOARD_KWORLD_ATSC_120         67
> #define CX88_BOARD_HAUPPAUGE_HVR4000       68
> #define CX88_BOARD_HAUPPAUGE_HVR4000LITE   69
> #define CX88_BOARD_TEVII_S460              70
> #define CX88_BOARD_OMICOM_SS4_PCI          71
> #define CX88_BOARD_TBS_8920                72
> #define CX88_BOARD_TEVII_S420              73
> #define CX88_BOARD_PROLINK_PV_GLOBAL_XTREME 74
> #define CX88_BOARD_PROF_7300               75
> #define CX88_BOARD_SATTRADE_ST4200         76
> #define CX88_BOARD_TBS_8910                77
> #define CX88_BOARD_PROF_6200               78
> #define CX88_BOARD_TERRATEC_CINERGY_HT_PCI_MKII 79
> #define CX88_BOARD_HAUPPAUGE_IRONLY        80
> #define CX88_BOARD_WINFAST_DTV1800H        81
> #define CX88_BOARD_WINFAST_DTV2000H_J      82
> #define CX88_BOARD_PROF_7301               83
> #define CX88_BOARD_SAMSUNG_SMT_7020        84
> #define CX88_BOARD_TWINHAN_VP1027_DVBS     85
> #define CX88_BOARD_TEVII_S464              86
> #define CX88_BOARD_WINFAST_DTV2000H_PLUS   87
> #define CX88_BOARD_WINFAST_DTV1800H_XC4000 88
> #define CX88_BOARD_WINFAST_TV2000_XP_GLOBAL_6F36 89
> #define CX88_BOARD_WINFAST_TV2000_XP_GLOBAL_6F43 90
> 
> #define MAX_CX88_INPUT 8
> 
> enum cx88_itype {
> 	CX88_VMUX_COMPOSITE1 = 1,
> 	CX88_VMUX_COMPOSITE2,
> 	CX88_VMUX_COMPOSITE3,
> 	CX88_VMUX_COMPOSITE4,
> 	CX88_VMUX_SVIDEO,
> 	CX88_VMUX_TELEVISION,
> 	CX88_VMUX_CABLE,
> 	CX88_VMUX_DVB,
> 	CX88_VMUX_DEBUG,
> 	CX88_RADIO,
> };
> 
> struct cx88_input {
> 	enum cx88_itype type;
> };
> 
> struct cx88_board {
> 	struct cx88_input       input[MAX_CX88_INPUT];
> };
> 
> static const struct cx88_board cx88_boards[] = {
> 	[CX88_BOARD_UNKNOWN] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE2,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE3,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE4,
> 		}},
> 	},
> 	[CX88_BOARD_HAUPPAUGE] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_DEBUG,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_GDI] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_PIXELVIEW] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_ATI_WONDER_PRO] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_WINFAST2000XP_EXPERT] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_AVERTV_STUDIO_303] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_MSI_TVANYWHERE_MASTER] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_WINFAST_DV2000] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_LEADTEK_PVR2000] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_IODATA_GVVCP3PCI] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE2,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_PROLINK_PLAYTVPVR] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_ASUS_PVR_416] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_MSI_TVANYWHERE] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_KWORLD_DVB_T] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_DVICO_FUSIONHDTV_DVB_T1] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_KWORLD_LTV883] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_DEBUG,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_CABLE,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_HAUPPAUGE_DVB_T1] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_DVB,
> 		}},
> 	},
> 	[CX88_BOARD_CONEXANT_DVB_T1] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_DVB,
> 		}},
> 	},
> 	[CX88_BOARD_PROVIDEO_PV259] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		}},
> 	},
> 	[CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_PLUS] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_DNTV_LIVE_DVB_T] = {
> 		.input		= {{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_PCHDTV_HD3000] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_HAUPPAUGE_ROSLYN] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_DEBUG,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_DIGITALLOGIC_MEC] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_IODATA_GVBCTV7E] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}}
> 	},
> 	[CX88_BOARD_PIXELVIEW_PLAYTV_ULTRA_PRO] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_T] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_ADSTECH_DVB_T_PCI] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_TERRATEC_CINERGY_1400_DVB_T1] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_DVB,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_DVICO_FUSIONHDTV_5_GOLD] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_AVERMEDIA_ULTRATV_MC_550] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		},{
> 			.type   = CX88_VMUX_TELEVISION,
> 		}},
> 	},
> 	[CX88_BOARD_KWORLD_VSTREAM_EXPERT_DVD] = {
> 		 .input          = {{
> 			 .type   = CX88_VMUX_COMPOSITE1,
> 		 },{
> 			 .type   = CX88_VMUX_SVIDEO,
> 		 }},
> 	},
> 	[CX88_BOARD_ATI_HDTVWONDER] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_WINFAST_DTV1000] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_DVB,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_AVERTV_303] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_HAUPPAUGE_NOVASPLUS_S1] = {
> 		.input		= {{
> 			.type	= CX88_VMUX_DVB,
> 		},{
> 			.type	= CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type	= CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_HAUPPAUGE_NOVASE2_S1] = {
> 		.input		= {{
> 			.type	= CX88_VMUX_DVB,
> 		}},
> 	},
> 	[CX88_BOARD_KWORLD_DVBS_100] = {
> 		.input		= {{
> 			.type	= CX88_VMUX_DVB,
> 		},{
> 			.type	= CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type	= CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_HAUPPAUGE_HVR1100] = {
> 		.input		= {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type	= CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type	= CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_HAUPPAUGE_HVR1100LP] = {
> 		.input		= {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type	= CX88_VMUX_COMPOSITE1,
> 		}},
> 	},
> 	[CX88_BOARD_DNTV_LIVE_DVB_T_PRO] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_KWORLD_DVB_T_CX22702] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_DUAL] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		 },{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_KWORLD_HARDWARE_MPEG_TV_XPERT] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_HYBRID] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_PCHDTV_HD5500] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_KWORLD_MCE200_DELUXE] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		}},
> 	},
> 	[CX88_BOARD_PIXELVIEW_PLAYTV_P7000] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		}},
> 	},
> 	[CX88_BOARD_NPGTECH_REALTV_TOP10FM] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_WINFAST_DTV2000H] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		}, {
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		}, {
> 			.type   = CX88_VMUX_COMPOSITE2,
> 		}, {
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_WINFAST_DTV2000H_J] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_GENIATECH_DVBS] = {
> 		.input  = {{
> 			.type  = CX88_VMUX_DVB,
> 		},{
> 			.type  = CX88_VMUX_COMPOSITE1,
> 		}},
> 	},
> 	[CX88_BOARD_HAUPPAUGE_HVR3000] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_NORWOOD_MICRO] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_TE_DTV_250_OEM_SWANN] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_HAUPPAUGE_HVR1300] = {
> 		.input		= {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type	= CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type	= CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_SAMSUNG_SMT_7020] = {
> 		.input		= { {
> 			.type	= CX88_VMUX_DVB,
> 		} },
> 	},
> 	[CX88_BOARD_ADSTECH_PTV_390] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_DEBUG,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_PINNACLE_PCTV_HD_800i] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_DVICO_FUSIONHDTV_5_PCI_NANO] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		}, {
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		}, {
> 			.type   = CX88_VMUX_SVIDEO,
> 		} },
> 	},
> 	[CX88_BOARD_PINNACLE_HYBRID_PCTV] = {
> 		.input          = { {
> 			.type   = CX88_VMUX_TELEVISION,
> 		}, {
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		}, {
> 			.type   = CX88_VMUX_SVIDEO,
> 		} },
> 	},
> 	[CX88_BOARD_WINFAST_TV2000_XP_GLOBAL] = {
> 		.input          = { {
> 			.type   = CX88_VMUX_TELEVISION,
> 		}, {
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		}, {
> 			.type   = CX88_VMUX_SVIDEO,
> 		} },
> 	},
> 	[CX88_BOARD_WINFAST_TV2000_XP_GLOBAL_6F36] = {
> 		.input          = { {
> 			.type   = CX88_VMUX_TELEVISION,
> 		}, {
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		}, {
> 			.type   = CX88_VMUX_SVIDEO,
> 		} },
> 	},
> 	[CX88_BOARD_WINFAST_TV2000_XP_GLOBAL_6F43] = {
> 		.input          = { {
> 			.type   = CX88_VMUX_TELEVISION,
> 		}, {
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		}, {
> 			.type   = CX88_VMUX_SVIDEO,
> 		} },
> 	},
> 	[CX88_BOARD_POWERCOLOR_REAL_ANGEL] = {
> 		.input          = { {
> 			.type   = CX88_VMUX_DEBUG,
> 			.type   = CX88_VMUX_TELEVISION,
> 		}, {
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		}, {
> 			.type   = CX88_VMUX_SVIDEO,
> 		} },
> 	},
> 	[CX88_BOARD_GENIATECH_X8000_MT] = {
> 		.input          = { {
> 			.type   = CX88_VMUX_TELEVISION,
> 		}, {
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		}, {
> 			.type   = CX88_VMUX_SVIDEO,
> 		} },
> 	},
> 	[CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_PRO] = {
> 		.input          = { {
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		}, {
> 			.type   = CX88_VMUX_SVIDEO,
> 		} },
> 	},
> 	[CX88_BOARD_DVICO_FUSIONHDTV_7_GOLD] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		},{
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		},{
> 			.type   = CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_PROLINK_PV_8000GT] = {
> 		.input          = { {
> 			.type   = CX88_VMUX_TELEVISION,
> 		}, {
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		}, {
> 			.type   = CX88_VMUX_SVIDEO,
> 		} },
> 	},
> 	[CX88_BOARD_PROLINK_PV_GLOBAL_XTREME] = {
> 		.input          = { {
> 			.type   = CX88_VMUX_TELEVISION,
> 		}, {
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		}, {
> 			.type   = CX88_VMUX_SVIDEO,
> 		} },
> 	},
> 	[CX88_BOARD_KWORLD_ATSC_120] = {
> 		.input          = { {
> 			.type   = CX88_VMUX_TELEVISION,
> 		}, {
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		}, {
> 			.type   = CX88_VMUX_SVIDEO,
> 		} },
> 	},
> 	[CX88_BOARD_HAUPPAUGE_HVR4000] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		}, {
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		}, {
> 			.type   = CX88_VMUX_SVIDEO,
> 		} },
> 	},
> 	[CX88_BOARD_HAUPPAUGE_HVR4000LITE] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_DVB,
> 		} },
> 	},
> 	[CX88_BOARD_TEVII_S420] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_DVB,
> 		} },
> 	},
> 	[CX88_BOARD_TEVII_S460] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_DVB,
> 		} },
> 	},
> 	[CX88_BOARD_TEVII_S464] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_DVB,
> 		} },
> 	},
> 	[CX88_BOARD_OMICOM_SS4_PCI] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_DVB,
> 		} },
> 	},
> 	[CX88_BOARD_TBS_8910] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_DVB,
> 		} },
> 	},
> 	[CX88_BOARD_TBS_8920] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_DVB,
> 		} },
> 	},
> 	[CX88_BOARD_PROF_6200] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_DVB,
> 		} },
> 	},
> 	[CX88_BOARD_PROF_7300] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_DVB,
> 		} },
> 	},
> 	[CX88_BOARD_SATTRADE_ST4200] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_DVB,
> 		} },
> 	},
> 	[CX88_BOARD_TERRATEC_CINERGY_HT_PCI_MKII] = {
> 		.input          = { {
> 			.type   = CX88_VMUX_TELEVISION,
> 		}, {
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		}, {
> 			.type   = CX88_VMUX_SVIDEO,
> 		} },
> 	},
> 	[CX88_BOARD_HAUPPAUGE_IRONLY] = {
> 	},
> 	[CX88_BOARD_WINFAST_DTV1800H] = {
> 		.input          = {{
> 			.type   = CX88_VMUX_TELEVISION,
> 		}, {
> 			.type   = CX88_VMUX_COMPOSITE1,
> 		}, {
> 			.type   = CX88_VMUX_SVIDEO,
> 		} },
> 	},
> 	[CX88_BOARD_WINFAST_DTV1800H_XC4000] = {
> 		.input		= {{
> 			.type	= CX88_VMUX_TELEVISION,
> 		}, {
> 			.type	= CX88_VMUX_COMPOSITE1,
> 		}, {
> 			.type	= CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_WINFAST_DTV2000H_PLUS] = {
> 		.input		= {{
> 			.type	= CX88_VMUX_TELEVISION,
> 		}, {
> 			.type	= CX88_VMUX_CABLE,
> 		}, {
> 			.type	= CX88_VMUX_COMPOSITE1,
> 		}, {
> 			.type	= CX88_VMUX_SVIDEO,
> 		}},
> 	},
> 	[CX88_BOARD_PROF_7301] = {
> 		.input          = { {
> 			.type   = CX88_VMUX_DVB,
> 		} },
> 	},
> 	[CX88_BOARD_TWINHAN_VP1027_DVBS] = {
> 		.input          = {{
> 		       .type   = CX88_VMUX_DVB,
> 		} },
> 	},
> };
> ------------------- cut here ------------------------
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

