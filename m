From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] compile-i386: do not generate an infinite loop
Date: Wed, 22 Jul 2009 12:30:42 -0700
Message-ID: <70318cbf0907221230o3f96ace7yc8e1d409e75891b2@mail.gmail.com>
References: <200907182334.10900.kdudka@redhat.com>
	 <200907221124.35339.kdudka@redhat.com>
	 <70318cbf0907220934p607b8c61g31fcec75e868d0d@mail.gmail.com>
	 <200907221921.58947.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f173.google.com ([209.85.221.173]:41478 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbZGVTan (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Jul 2009 15:30:43 -0400
Received: by qyk3 with SMTP id 3so573929qyk.33
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2009 12:30:42 -0700 (PDT)
In-Reply-To: <200907221921.58947.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Wed, Jul 22, 2009 at 10:21 AM, Kamil Dudka<kdudka@redhat.com> wrote:
> Sorry for my ignorance, I've never heard about the Linus filter. Could you
> please point me to some relevant info? For now we only want to play with
> separation logic and use it for static analysis of code as part of our
> research at FIT BUT.

Of course you haven't heard of it. I just make it up myself.  A Linus filter
is a program that take bad C code as input and output good C code as if
it is written by Linus himself. We just need to hook it to LKML.

Chris
