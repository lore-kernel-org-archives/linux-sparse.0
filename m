From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: sparse memset warnings
Date: Wed, 29 Nov 2006 10:10:26 -0800
Message-ID: <20061129101026.8aeb47ac.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:62639 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S967496AbWK2SJ7 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 29 Nov 2006 13:09:59 -0500
Received: from rgmgw3.us.oracle.com (rgmgw3.us.oracle.com [138.1.186.112])
	by agminet01.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id kATI9vXH013688
	for <linux-sparse@vger.kernel.org>; Wed, 29 Nov 2006 12:09:57 -0600
Received: from midway.site (dhcp-amer-csvpn-gw1-141-144-64-8.vpn.oracle.com [141.144.64.8])
	by rgmgw3.us.oracle.com (Switch-3.2.4/Switch-3.1.7) with SMTP id kATI9uZr022059
	for <linux-sparse@vger.kernel.org>; Wed, 29 Nov 2006 11:09:56 -0700
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

in 2.6.19-rc6-mm2, kvm:

drivers/kvm/kvm_main.c:632:9: error: too many arguments for function memset
drivers/kvm/kvm_main.c:647:9: error: too many arguments for function memset
drivers/kvm/kvm_main.c:733:9: error: too many arguments for function memset
drivers/kvm/kvm_main.c:1866:8: error: too many arguments for function memset

I don't see the problem...

---
~Randy
