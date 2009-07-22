From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: [PATCH] compile-i386: do not generate an infinite loop
Date: Wed, 22 Jul 2009 11:24:35 +0200
Message-ID: <200907221124.35339.kdudka@redhat.com>
References: <200907182334.10900.kdudka@redhat.com> <70318cbf0907220138g412388fam12f31f03c25ebf1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:49263 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbZGVJZY (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Jul 2009 05:25:24 -0400
In-Reply-To: <70318cbf0907220138g412388fam12f31f03c25ebf1f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jeff@garzik.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Wed July 22 2009 10:38:43 Christopher Li wrote:
> Adding Jeff to the CC list. The compile-i386.c is Jeff's pet project.
> The change looks good to me. I would like to give Jeff some time
> to comment it before I apply the patch.

Thanks!

> BTW, have you take a look at Linus's example.c? It is based on the
> linearized byte code and It does more advance stuff like simple
> register allocation. In my opinion example.c is a better place to start
> hacking compiler back end  than compile.c

Linus's example.c works fine with the same test-case. I decided to take 
compile.c as template just because it doesn't use the linearized code.
The tree structure better accomplishes my requirements for now. Maybe I'll 
turn to byte code in future. I've just started to play with it.

Anyway SPARSE seems to be quite helpful. It's easy to read and can save
a lot of development time while processing C sources.

Kamil

