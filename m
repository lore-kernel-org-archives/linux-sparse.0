From: Bastien Nocera <hadess@hadess.net>
Subject: False positives unlock warning
Date: Wed, 14 Jan 2015 14:46:58 +0100
Message-ID: <1421243218.2542.45.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:41515 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbbANNrw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 14 Jan 2015 08:47:52 -0500
Received: from mfilter12-d.gandi.net (mfilter12-d.gandi.net [217.70.178.129])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 98974A80AC
	for <linux-sparse@vger.kernel.org>; Wed, 14 Jan 2015 14:47:50 +0100 (CET)
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter12-d.gandi.net (mfilter12-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id rj1me5giwS+I for <linux-sparse@vger.kernel.org>;
	Wed, 14 Jan 2015 14:47:49 +0100 (CET)
Received: from nuvo (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
	(Authenticated sender: hadess@hadess.net)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 46116A80D3
	for <linux-sparse@vger.kernel.org>; Wed, 14 Jan 2015 14:47:47 +0100 (CET)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hey,

The following project (a device driver which should compile with kernel
3.17 and above) throws a few false positives with "make C=1":
core/rtw_recv.c:3406:26: warning: context imbalance in 'recv_indicatepkt_reorder' - unexpected unlock
core/rtw_xmit.c:4300:6: warning: context imbalance in 'xmit_delivery_enabled_frames' - wrong count at exit

The code however doesn't look like it's doing anything problematic.

Any ideas?

Cheers

