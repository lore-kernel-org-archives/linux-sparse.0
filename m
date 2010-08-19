From: Bernd Petrovitsch <bernd@sysprog.at>
Subject: Lots of "error: multiple storage classes" warnings on the Linux
 kernel
Date: Thu, 19 Aug 2010 14:53:12 +0200
Message-ID: <1282222392.10440.60.camel@thorin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:2335 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752886Ab0HSMxO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 19 Aug 2010 08:53:14 -0400
Received: from [172.16.0.10] (chello062178036229.13.11.wu-wien.teleweb.at [62.178.36.229])
	(authenticated bits=0)
	by esgaroth.petrovitsch.priv.at (8.14.1/8.14.1) with ESMTP id o7JCrCHE013960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Thu, 19 Aug 2010 14:53:13 +0200
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi all!

While investigating something completely different, I noticed lots of 
"error: multiple storage classes" warnings, e.g.
----  snip  ----
  CHECK   security/keys/keyring.c
include/linux/sched.h:831:12: error: multiple storage classes: extern weak
security/keys/keyring.c:75:1: error: multiple storage classes: extern weak
security/keys/keyring.c:471:1: error: multiple storage classes: extern weak
security/keys/keyring.c:899:1: error: multiple storage classes: extern weak
security/keys/keyring.c:974:1: error: multiple storage classes: extern weak
security/keys/keyring.c:1033:1: error: multiple storage classes: extern weak
----  snip  ---- 
[ The ": extern weak" is from me to see which are actually set. ]

Is this warning correct that way (and the source should be fixed) or is
the warning in that wrong?

	Bernd 
-- 
mobile: +43 664 4416156              http://www.sysprog.at/
    Linux Software Development, Consulting and Services

