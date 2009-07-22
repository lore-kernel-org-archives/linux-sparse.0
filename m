From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] compile-i386: do not generate an infinite loop
Date: Wed, 22 Jul 2009 09:39:42 -0700
Message-ID: <70318cbf0907220939s48bcfd3fi20ae9fda1edd290@mail.gmail.com>
References: <200907182334.10900.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f173.google.com ([209.85.221.173]:39374 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753694AbZGVQjo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Jul 2009 12:39:44 -0400
Received: by qyk3 with SMTP id 3so389298qyk.33
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2009 09:39:42 -0700 (PDT)
In-Reply-To: <200907182334.10900.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Oh one last thing. I need a signed-off line from you.

Chris

On Sat, Jul 18, 2009 at 2:34 PM, Kamil Dudka<kdudka@redhat.com> wrote:
> Hello,
>
> I've probably encountered a bug within compile-i386.c. It generates
> an infinite loop for 'while' statement. My testing example and proposed
> patch are enclosed.
>
> Kamil
>
