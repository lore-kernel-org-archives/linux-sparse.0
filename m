From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] make sparse headers self-compilable...
Date: Tue, 11 Aug 2009 02:40:45 -0700
Message-ID: <70318cbf0908110240w5067933dv92e92829c0bb2e8f@mail.gmail.com>
References: <200908072227.08652.kdudka@redhat.com>
	 <200908081310.27671.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f172.google.com ([209.85.212.172]:48193 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbZHKL5F (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Aug 2009 07:57:05 -0400
Received: by vws2 with SMTP id 2so3296502vws.4
        for <linux-sparse@vger.kernel.org>; Tue, 11 Aug 2009 04:57:06 -0700 (PDT)
In-Reply-To: <200908081310.27671.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 8, 2009 at 4:10 AM, Kamil Dudka<kdudka@redhat.com> wrote:
> On Friday 07 of August 2009 22:27:08 Kamil Dudka wrote:
>> attached is another fix for SPARSE headers improving their sanity. I am
>> also attaching a simple test for the dependency tracking of headers. It's
>> not enough generic and portable and therefore not really useful. Maybe
>> someone skilled in writing makefiles might want to include something like
>> that to the SPARSE Makefile as part of the 'check' target.

What is the significant of making every header file self compilable?
Unlike the kernel header files exported to user space, which usually
have self contained meaning. Most of these header file have tight interaction
with each other. I don't think it make sense for other sparse application
to just use one of the header file.

Enforcing each header file to be self compilable will result in a lot
of unnecessary include. Gcc needs to include "symbol.h" many times
just to skip over it. Take a look at pre-process.c. It is not exactly
trivial. It needs to scan the token to find out the end of the if
scope. In this case, it might be better just let other header
file depend on "symbol.h".

I want to heard what other people think about it too. I am a little bit
reluctant on this one.

Chris
