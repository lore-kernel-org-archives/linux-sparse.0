From: Reza Roboubi <reza@earthdetails.com>
Subject: preprocess(), external_declaration(),  writing a "smart" editor
Date: Mon, 04 Feb 2008 07:07:58 -0800
Message-ID: <47A72A4E.8070108@earthdetails.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:17413 "EHLO
	pd2mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbYBDPGG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Feb 2008 10:06:06 -0500
Received: from pd3mr2so.prod.shaw.ca
 (pd3mr2so-qfe3.prod.shaw.ca [10.0.141.178]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JVP00M2GZA4OP00@l-daemon> for linux-sparse@vger.kernel.org;
 Mon, 04 Feb 2008 08:06:04 -0700 (MST)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
 by pd3mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JVP00D1WZA21A90@pd3mr2so.prod.shaw.ca> for
 linux-sparse@vger.kernel.org; Mon, 04 Feb 2008 08:06:02 -0700 (MST)
Received: from [192.168.0.46] ([24.80.205.34])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JVP00KP7ZA3SQ40@l-daemon> for linux-sparse@vger.kernel.org;
 Mon, 04 Feb 2008 08:06:03 -0700 (MST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Consider an editor that can do search & replace for all instances of
'size', but only when 'size' is a member of 'struct list'.  (Even
if 'size' is being referenced from inside a macro.)

I'm very interested in writing an open source editor for this.
If this is stupid, please tell me!

I've glanced at the source code.  Can you help me find out if sparse is
right for this?

Thanks a lot.

Reza.
