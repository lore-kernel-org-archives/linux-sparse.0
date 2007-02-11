From: Andi Kleen <ak@suse.de>
Subject: Re: [ANNOUNCE] sparse-0.2-cl2 is now available
Date: Sun, 11 Feb 2007 11:41:54 +0100
Message-ID: <200702111141.54900.ak@suse.de>
References: <20070204085329.GA6520@chrisli.org> <20070211055015.GR10050@ftp.linux.org.uk> <20070211060255.GA2312@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37943 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172AbXBKKmG (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 11 Feb 2007 05:42:06 -0500
In-Reply-To: <20070211060255.GA2312@chrisli.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org, linux kernel mail list <linux-kernel@vger.kernel.org>, Josh Triplett <josh@freedesktop.org>


> 
> If we keep it 10 times over head, my home computer can load the full linux
> kernel and have some spare for checking.
> 
> I am still working on the bytecode loader and linker for merging symbols.
> It need to answer the question:
> 
> Which file define which function.
> Which external symbol does this function use.
> 
> Once we get the function user/define chain, it can enable a lot of new checking.

At least for interrupts on/off you'll likely need new annotations because
this state can be changed in assembly files before/after calling out to 
C.

For locks this fortunately cannot happen (at least not on x86*) 

-Andi
