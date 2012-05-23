From: Shakthi Kannan <shakthimaan@gmail.com>
Subject: Re: Using c2xml on kernel sources
Date: Wed, 23 May 2012 15:29:03 +0530
Message-ID: <CABG-yt2rCSESURVA4NOJe6Cwyxj0saTN1oJcMYE3kAgsNtULQA@mail.gmail.com>
References: <CABG-yt06Kw2uFnmrshcHYjgf_cMgzKVdMPe6BXOP2nryhRjBpg@mail.gmail.com>
	<20120320103702.GN3163@mwanda>
	<CABG-yt2bs8wGUgTH9=dPgtD22vER8qd5JFZGXgPj9f+NS-OHmQ@mail.gmail.com>
	<20120320154048.GA7848@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36329 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747Ab2EWJ7F (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 May 2012 05:59:05 -0400
Received: by wgbdr13 with SMTP id dr13so6974149wgb.1
        for <linux-sparse@vger.kernel.org>; Wed, 23 May 2012 02:59:03 -0700 (PDT)
In-Reply-To: <20120320154048.GA7848@mwanda>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

Replying to my own post (for future reference):

--- On Tue, Mar 20, 2012 at 08:55:48PM +0530, Shakthi Kannan wrote:
| But, is it really required to generate eth.o? Is it possible to just
| parse through the sources, produce the .xml output without having to
| generate the object files?
\--

I had to use:

MAKEFLAGS+="--dry-run" make C=2 CHECK="c2xml > foo.xml"
net/ethernet/eth.o > output.txt

eval `tail -2 output.txt | head -1`

SK

-- 
Shakthi Kannan
http://www.shakthimaan.com
