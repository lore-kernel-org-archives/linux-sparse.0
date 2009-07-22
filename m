From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] compile-i386: do not generate an infinite loop
Date: Wed, 22 Jul 2009 09:34:13 -0700
Message-ID: <70318cbf0907220934p607b8c61g31fcec75e868d0d@mail.gmail.com>
References: <200907182334.10900.kdudka@redhat.com>
	 <70318cbf0907220138g412388fam12f31f03c25ebf1f@mail.gmail.com>
	 <200907221124.35339.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f173.google.com ([209.85.221.173]:46339 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbZGVQeO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Jul 2009 12:34:14 -0400
Received: by qyk3 with SMTP id 3so383329qyk.33
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2009 09:34:13 -0700 (PDT)
In-Reply-To: <200907221124.35339.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Wed, Jul 22, 2009 at 2:24 AM, Kamil Dudka<kdudka@redhat.com> wrote:
> Anyway SPARSE seems to be quite helpful. It's easy to read and can save
> a lot of development time while processing C sources.

Just curious, what are you trying to build with sparse? A Linus filter would be
pretty cool.

BTW, I want to start some hacking guide for sparse. I am particular interested
in what is the common pain when a new hacker try to work on sparse. Do you
find sparse pretty easy to learn on?

Chris
