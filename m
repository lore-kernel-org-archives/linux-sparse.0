From: Shakthi Kannan <shakthimaan@gmail.com>
Subject: Re: Using c2xml on kernel sources
Date: Tue, 20 Mar 2012 20:55:48 +0530
Message-ID: <CABG-yt2bs8wGUgTH9=dPgtD22vER8qd5JFZGXgPj9f+NS-OHmQ@mail.gmail.com>
References: <CABG-yt06Kw2uFnmrshcHYjgf_cMgzKVdMPe6BXOP2nryhRjBpg@mail.gmail.com>
	<20120320103702.GN3163@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56135 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760327Ab2CTPZt (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 20 Mar 2012 11:25:49 -0400
Received: by wgbdr13 with SMTP id dr13so86523wgb.1
        for <linux-sparse@vger.kernel.org>; Tue, 20 Mar 2012 08:25:48 -0700 (PDT)
In-Reply-To: <20120320103702.GN3163@mwanda>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-sparse@vger.kernel.org

Hi Dan:

--- On Tue, Mar 20, 2012 at 4:07 PM, Dan Carpenter
<dan.carpenter@oracle.com> wrote:
| make C=2 CHECK="c2xml > foo.xml" net/ethernet/eth.o
\--

That worked!

But, is it really required to generate eth.o? Is it possible to just
parse through the sources, produce the .xml output without having to
generate the object files?

Thanks for your reply,

SK

-- 
Shakthi Kannan
http://www.shakthimaan.com
