From: Reza Roboubi <reza@earthdetails.com>
Subject: ./graph | dot > bad.png
Date: Thu, 31 Jan 2008 12:13:05 -0800
Message-ID: <47A22BD1.9020101@earthdetails.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:64774 "EHLO
	pd3mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585AbYAaUME (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 31 Jan 2008 15:12:04 -0500
Received: from pd4mr2so.prod.shaw.ca
 (pd4mr2so-qfe3.prod.shaw.ca [10.0.141.213]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JVI00EPWYQR9H30@l-daemon> for linux-sparse@vger.kernel.org;
 Thu, 31 Jan 2008 13:11:15 -0700 (MST)
Received: from pn2ml1so.prod.shaw.ca ([10.0.121.145])
 by pd4mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JVI00IFOYQRY910@pd4mr2so.prod.shaw.ca> for
 linux-sparse@vger.kernel.org; Thu, 31 Jan 2008 13:11:16 -0700 (MST)
Received: from [192.168.0.46] ([24.80.205.34])
 by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JVI00MT8YQQWFE0@l-daemon> for linux-sparse@vger.kernel.org;
 Thu, 31 Jan 2008 13:11:15 -0700 (MST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

I'm not quite sure how to read this png file, it doesn't
look right. (The call arrows should go out of lines 10 and 11, no?)
http://reza.parvan.net/public/graph.png
And here's the command line:
./graph mytest.c |./gvpr/return-paths |./gvpr/subg-fwd -a main|\
dot -Tpng > graph.png
http://reza.parvan.net/public/mytest.c

Thanks.

Reza.
