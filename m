From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] compile-i386: do not generate an infinite loop
Date: Wed, 22 Jul 2009 01:38:43 -0700
Message-ID: <70318cbf0907220138g412388fam12f31f03c25ebf1f@mail.gmail.com>
References: <200907182334.10900.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f173.google.com ([209.85.221.173]:36984 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbZGVIin (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Jul 2009 04:38:43 -0400
Received: by qyk3 with SMTP id 3so28906qyk.33
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2009 01:38:43 -0700 (PDT)
In-Reply-To: <200907182334.10900.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>, Jeff Garzik <jeff@garzik.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Jul 18, 2009 at 2:34 PM, Kamil Dudka<kdudka@redhat.com> wrote:
> Hello,
>
> I've probably encountered a bug within compile-i386.c. It generates
> an infinite loop for 'while' statement. My testing example and proposed
> patch are enclosed.

Adding Jeff to the CC list. The compile-i386.c is Jeff's pet project.
The change looks good to me. I would like to give Jeff some time
to comment it before I apply the patch.

BTW, have you take a look at Linus's example.c? It is based on the
linearized byte code and It does more advance stuff like simple
register allocation. In my opinion example.c is a better place to start
hacking compiler back end  than compile.c

Chris
