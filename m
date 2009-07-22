From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: [PATCH] compile-i386: do not generate an infinite loop
Date: Wed, 22 Jul 2009 19:21:58 +0200
Message-ID: <200907221921.58947.kdudka@redhat.com>
References: <200907182334.10900.kdudka@redhat.com> <200907221124.35339.kdudka@redhat.com> <70318cbf0907220934p607b8c61g31fcec75e868d0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:33861 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752388AbZGVRXJ (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Jul 2009 13:23:09 -0400
In-Reply-To: <70318cbf0907220934p607b8c61g31fcec75e868d0d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jeff@garzik.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Wednesday 22 of July 2009 18:34:13 Christopher Li wrote:
> Just curious, what are you trying to build with sparse? A Linus filter
> would be pretty cool.

Sorry for my ignorance, I've never heard about the Linus filter. Could you 
please point me to some relevant info? For now we only want to play with 
separation logic and use it for static analysis of code as part of our 
research at FIT BUT.

> BTW, I want to start some hacking guide for sparse. I am particular
> interested in what is the common pain when a new hacker try to work on
> sparse. Do you find sparse pretty easy to learn on?

I've just written my first "hello world" SPARSE client (nothing useful yet) 
and I am going to write the same as gcc-4.5 plug-in and compare it with each 
other - what is similar, what is different etc.

I haven't encountered any problem while learning SPARSE yet. The code is easy 
to read and the examples sufficient. Maybe worth to write some brief 
description of the particular examples within README? I'll come with some 
ideas later if any.

Kamil
