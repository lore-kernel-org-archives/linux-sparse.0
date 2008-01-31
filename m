From: Reza Roboubi <reza@earthdetails.com>
Subject: Re: ./graph | dot > bad.png
Date: Thu, 31 Jan 2008 12:17:31 -0800
Message-ID: <47A22CDB.8030307@earthdetails.com>
References: <47A22BD1.9020101@earthdetails.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:56434 "EHLO
	pd2mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078AbYAaURQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 31 Jan 2008 15:17:16 -0500
Received: from pd4mr5so.prod.shaw.ca (pd4mr5so-qfe3.prod.shaw.ca [10.0.141.50])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JVI0037JYY5N3B0@l-daemon> for linux-sparse@vger.kernel.org;
 Thu, 31 Jan 2008 13:15:41 -0700 (MST)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
 by pd4mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JVI006DUYY4RCA0@pd4mr5so.prod.shaw.ca> for
 linux-sparse@vger.kernel.org; Thu, 31 Jan 2008 13:15:40 -0700 (MST)
Received: from [192.168.0.46] ([24.80.205.34])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JVI009ZAYY36350@l-daemon> for linux-sparse@vger.kernel.org;
 Thu, 31 Jan 2008 13:15:39 -0700 (MST)
In-reply-to: <47A22BD1.9020101@earthdetails.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Reza Roboubi wrote:
> I'm not quite sure how to read this png file, it doesn't
> look right. (The call arrows should go out of lines 10 and 11, no?)
> http://reza.parvan.net/public/graph.png
> And here's the command line:
> ./graph mytest.c |./gvpr/return-paths |./gvpr/subg-fwd -a main|\

Oh I see, it's the subgraph that's being forwarded.  Great. Thanks.

Reza.

> dot -Tpng > graph.png
> http://reza.parvan.net/public/mytest.c
> 
> Thanks.
> 
> Reza.
> 
