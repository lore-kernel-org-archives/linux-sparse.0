Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EE338E
	for <linux-sparse@vger.kernel.org>; Fri, 19 Jan 2024 23:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705705793; cv=fail; b=l+YddiA2Es0USvOMx47y4zctBRF8RjeemTyGCNtOoGsBsm0nmqKqysB0iXxXP7BI0OjQcuUWVD1xPs3ejLw3rlX2xtO1mjoIO11IyXOwZNcC7ZlL180+YlLk/XVw6E+lp4EOvKM78bCJwkonibuhYqr4HWSjTzlyBR6fNjWvNq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705705793; c=relaxed/simple;
	bh=QhMNpJ5w0yBwr3kiXftXKRyVGICYvdMqHY0O63uR+dU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bpZi9942dpPCi/3OPllqlXXXzS1HdUKcCRxgqM6+9cRrcGQC07LCSWrc5UeotrtgqfGtpy7tCJO76ZfzfZhkMB9HJmkeO6GuwHgfSeBdnmMd+qdXCo8nJn5sXFjIgWUz9ODBAi1J8qSCZayrRqWfhCVspMyS6vDVs4gTvx8p6jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+ZWr0ji; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+ZWr0ji"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705705791; x=1737241791;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QhMNpJ5w0yBwr3kiXftXKRyVGICYvdMqHY0O63uR+dU=;
  b=A+ZWr0ji8BKC4RQ59rGABdo96uxvUjJHwQ/h47tS9KH8lxELMsQ4fGZb
   VAD+HZW06C5TDYJNM0F1fW6JnhuwVQHQlX/j7Tr5V+XXrgvmcWzyRYNiM
   EiGJGBFpedDKBUPZ2lXLDYhx2QKh8nHyIf7kVJ3miYUMkJy2dsSfSQB/D
   ASxet1/Th/1jxiLxiGthuRKgBzUF0Q4BsuPU8NA8iOnRnfVBz34/PgI4Y
   3sXqNha0u1XHYrrpJ4v2Pk9o+mb8Se/v/AH8MVgNbg0M5O7djmso/EeFb
   Rzg0+SEJf6duMZ9gP1pe2ECMlxNZbRPO7ftS4sL6Kkv2qyxMNfmA1pP8y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="404633337"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="404633337"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 15:09:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="718198"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2024 15:09:51 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 15:09:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Jan 2024 15:09:50 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Jan 2024 15:09:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gO+i3+D0mC3IOU9WouFVVaOFtGJrF7Z2xskMrVZ+KOGYrXNx3HrjoMv/X9r/fbeMdlpPrAgBy7wDg80GepO/0YrdTUx+Q7byUwoyn+O1mUC490b86THW10g026V7E6WMlMABYIJgpUELFGpyb52I2j8NCZK+59mkC2TSaRHteqpyME7a1aC+Lv5VdlqXokCM5aqoVdMA7VOYjIAIB5OLnSfny6IwI6wmZah3ZtAsabXjEBHbKfXL984Yk4qZb+wnOKQZWzCeFXeIkhhby5zmRIYxePMmqYRhYfOgZY2rCezKtolC1RYfJNqbzOKWNqlBTp7nF6STQXJHGjaOftQC8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhMNpJ5w0yBwr3kiXftXKRyVGICYvdMqHY0O63uR+dU=;
 b=eVt9drX4QqBK1GPN3btdWsKc8/n1f3gBIpB7zW8FgomoYinhFsVZhDn3LAdGjwgtQf1f+h3scusrTazWScp2PcvapunmPSbORUVJtCRAZcQf2fLpopMCkEoyfMtocqW9J9c2Tcm5dmGCfytNOWk17kS/krZR/hN1QXfmiuGA1JMPPlIGeNBr8iNhEocPfxPofT3wPUCpBB3lYtF3NGdpCwYJy+iZwEP/8oDLz5JcmCshe5TPNr3FJ7VL6IGfycQ37kgc+7jowXB2g7I+k9PO9lm11tJSmLJXhT+kEJRLdqjhJ3cIteCwfFX/rIe7xR8rRoPyntku0ojorh0B8AH0ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5869.namprd11.prod.outlook.com (2603:10b6:303:168::9)
 by SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Fri, 19 Jan
 2024 23:09:48 +0000
Received: from MW4PR11MB5869.namprd11.prod.outlook.com
 ([fe80::4521:29d2:4724:b773]) by MW4PR11MB5869.namprd11.prod.outlook.com
 ([fe80::4521:29d2:4724:b773%6]) with mapi id 15.20.7202.026; Fri, 19 Jan 2024
 23:09:47 +0000
From: "Herbert, Marc" <marc.herbert@intel.com>
To: Luc Van Oostenryck <lucvoo@kernel.org>
CC: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>
Subject: Christmas wish list: -Werror and -Wno-warn-about-X
Thread-Topic: Christmas wish list: -Werror and -Wno-warn-about-X
Thread-Index: AQHaSyyYMExJWxPZHkKGYp44Jvaxwg==
Date: Fri, 19 Jan 2024 23:09:47 +0000
Message-ID: <28F15CC0-6BCF-411C-8481-9EC8900B8372@intel.com>
References: <6A3A9274-C059-467A-89A8-54815D5461BC@intel.com>
 <AD16C022-C5F3-4DA2-A1A0-775E4C95A7A1@intel.com>
 <xwsuvxor4dwmmabaf3f7acgo53rkjigtzxqfgdmlibkgejb2m3@ib6s5sn5njgv>
 <4EB87136-D1B0-41CF-B552-9E9F19C00F3B@intel.com>
 <hgs2cgb2auv5y3apocuig6xjhmv3oy5hbzmvjxrxoharjb3fzy@mhjaitwlrnvy>
In-Reply-To: <hgs2cgb2auv5y3apocuig6xjhmv3oy5hbzmvjxrxoharjb3fzy@mhjaitwlrnvy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.300.61.1.2)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5869:EE_|SN7PR11MB8109:EE_
x-ms-office365-filtering-correlation-id: 976208f4-0422-4023-0ba9-08dc1943bb5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D/4oAYjQXtQ5137zgEK58VF6r/b0c6sur5q5+PJEfTfhmCxrZHV/AXpVbdJISF5aB1nk93T1YbCdrogfi1CmAU0KsrCnrUJRIRB95FvDDh/5lCUGoLXJ4zvRRS8vr9T01ZggfbWppIajRniCXJWuTLLHa/q16A8TDOnS8GBzVXE3/nJK5MOmOiLxpV6nIu1RQILekhRJf78PueKkGCV5ltRq8DFAZJ+vMDleYRsiUvD1TFhE7ZaSHFV/Z8Cu8EuXwg98IDeQn9NALCSfg8LjW7/VJFHauKtls0rBksh4nZ3ETHsyWfsWamzSxMoy1X0IjGj/plrdLk5l8p8JK5IlzRuHhjGS1VgWWn0j/sVmAOG8YTEpULG8hKh15+er9a5Bb9cnEh/iYVq5Mcs4R3phJ0KRLJX/T/ap7arqWDHGSmhJgIQyH0WaJo0FrphVBENG24CawAxpeh1yQ5Lr24uiPJbSYh/6Cf2IFtZemKgeUqy4+6HmaklM7Vs9NiA9mCPT8kNImH3Bv/5CWB+uwUKBXhQ220djV+BZfH6GiJft3GWx+CHSoLyCBNvgLGipb/fw9ysRpbgQD7AwZIZDZVMtODKUvEXyhxmwRJP0MscCMqjQv49CKiJiRQlBzno1Cdd3KZmvQY99+X0QgdyQ17gv8GiUtS1bU/rhTt0EYphiiGA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(230173577357003)(230273577357003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(966005)(6512007)(6916009)(2616005)(83380400001)(4326008)(316002)(64756008)(122000001)(26005)(38100700002)(8676002)(2906002)(71200400001)(6506007)(76116006)(41300700001)(478600001)(66446008)(8936002)(6486002)(66946007)(66556008)(5660300002)(86362001)(36756003)(66476007)(33656002)(82960400001)(38070700009)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pRwZmN/bhE7ilX/AN2BVTYsk5JRPaq+8tfjkll3OBUUlFtrUSPIwJfNbMM33?=
 =?us-ascii?Q?L8Ay4ZBKxmi4odDmVWKDVpOw4g7J2krb5X/bOCuWxIVr9ZN5J6NB/AXv6QAn?=
 =?us-ascii?Q?ZS2Qm0+HMAd3MgYUhDYDU3qyjNyNiB9WPxhtp9cNdd34zApvsnL9T6YeA6lY?=
 =?us-ascii?Q?/3fHmiRSsjQjzCKD/NcHb0RxUFCznykmbMo4ll3dpc8B4S21pPeyMCSUou3s?=
 =?us-ascii?Q?wxrEAhxdqV7D8lOUf1Ce55MT9hNrL3ODAAhyCUtp02HtGqKbRUNyivxLhA5K?=
 =?us-ascii?Q?jONOUPfv8ljpNnOE8KlBD4NKpvSc7Y/teVCw2w1i66YOS6nr9CEEGOw/zbO7?=
 =?us-ascii?Q?lN+m9+N5hfZtrM0nzkRIxqjSzr/uCnMCFG0j3mzq4namwX5H1ywylN9bxX8s?=
 =?us-ascii?Q?NCScx/QN07vfCUuakGbIo37B6kJv6klroneHmrm5Gz+nKTFGyCN558aAbXv1?=
 =?us-ascii?Q?x4hx2l4gADEqJB3aRc7Rm1ICPP0K/kexKpiK3dyr443j6xSc2KWALfYi9Xwr?=
 =?us-ascii?Q?wMNHEU6nQW2A/NMk7TGFFZYMQCo0ptY1e/9WHS8qdtihKbObekTXtTnObuXw?=
 =?us-ascii?Q?gY5cgq3TL8BV5ArvEUDHF4QSZdsVI5S5GFauYMOiDc+InTc1+macvehl7ZQt?=
 =?us-ascii?Q?/kPGgiw2HVLMQXA7C/wLnuSuog3gev+TKOl98NxDal3PKl/0SSUDfblczwdN?=
 =?us-ascii?Q?eImkIRCNObW4O5qpq1FfBmx+kTtinXdtdzUgBGZOdmK2vKdeGPzggrKN8+VL?=
 =?us-ascii?Q?Q0smRPXQsF2n4t7fov8tKoFv+Yz01SJzNiL/ydBUJ6ruiYN2jz9Gme+rzUeJ?=
 =?us-ascii?Q?7V7Wie33/A5qmTrahaTWxcX0/Jy+JyHUcA5zMe39q/3EKI+LQ85+hO6S9t/l?=
 =?us-ascii?Q?Mox7/zHPSoEw7e5nphLvzYR85Z74YnmH1K1Xh0yQ3ZIm+ay5spyN+qL04f3g?=
 =?us-ascii?Q?Aa/7dT9do4Q3jeyY5fPjkZBHMrBIeKmsqF7UD8lITf+Kin8zO+qcgr/luKTT?=
 =?us-ascii?Q?Ba1x3KCbBRO9JKB2FW3cZBcDeoH1FPE4yQSoc9XkYcL4QCAN+GioJiEwHxAd?=
 =?us-ascii?Q?XwcriilcsLszxt6h38Ie7CwOuu5cfolzybZgjWDDzlA8olEPh3gn70MkAr6U?=
 =?us-ascii?Q?CFZcFfRNdYS+frY3mfTLxpMvE4heD0xS1h7pmr/JtjmKgWrHyPkgQ36HndZZ?=
 =?us-ascii?Q?dyibplL14Fousk8ubUxI8eDEPqJAXAOfeVLUCDnVtUNIA3xSSt31prgk3fzt?=
 =?us-ascii?Q?7PF5Yb5PZzRiMQ050FIFkovASz50sAM7wOYEkt05yCH9zHjBIUDb2TgRf/np?=
 =?us-ascii?Q?F7F7yX7iiNO2vjRZsmEVvKaEu7OP+EhBgP90Oj9QVUNwo+bCNAalyk8/myH1?=
 =?us-ascii?Q?YS9TVTffZcGVqfeoHr3YqrxBSgjL6FEg8hsp6Txai9O4gS1R42PbY2IG+jgV?=
 =?us-ascii?Q?L8LzMEcrHYeyUGFPKFLXruE1gWxvWRiPfVSN6oQqwVpdPC74RxA0Kidi3muV?=
 =?us-ascii?Q?MoIdZUaR9t+ScrmnMwIrvvLKI5f2CzI5lGpOmTODmhUi1oBPDBciA94LNZsY?=
 =?us-ascii?Q?sQtth1xzMkcyaw0WdTWvvsopyJyIxc4ZKylB6v+pthXcXbUs4zQvwqsz+WTP?=
 =?us-ascii?Q?uA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A66AB6B509922344AEED207B2E229351@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976208f4-0422-4023-0ba9-08dc1943bb5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 23:09:47.6410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k+Pl7B3ZnV6vzZE7urhRYSXRoTVK/6mo3qbuqln1gT2dYP9aTfyj0ZwekJmNbby6tWLSSjvW2D0jH2uFquN/3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8109
X-OriginatorOrg: intel.com


> Anyway, with this it was very easy to reproduce and find the cause.
> Fixed and pushed, so mainline Sparse should be OK now.

> Many thanks for the bug report,

Fix confirmed, many thanks for the super quick fix!

It's also great to see that you seem to have more time to spend on
sparse right now. So trying to push my luck, here's the number 1 item on
my "Christmas Wish List": a combination of -Werror and -Wno-warn-about-X
options that would provides finer-grained and generally better control
on the exit status and output. After maintaining sparse automation for
many months, this is I think what would lower the CI adoption bar the
most.

So far we've been using a brittle script that captures the incredibly
verbose and mostly unusable output (mostly due to some hard-to-fix
warnings located in common .h files) and "post-processes" it
with... "grep".
 https://github.com/thesofproject/sof/commit/b7708182fbe5d

I'm curious how people typically automate runnning sparse on the
Linux kernel. Does everyone "greps" logs too? Or is it more like
`$(wc -l) =3D=3D 0`?

