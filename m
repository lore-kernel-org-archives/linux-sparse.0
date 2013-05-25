From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 5/5] lib.c: Add __sync_lock_test_and_set as a builtin
 function
Date: Sat, 25 May 2013 20:40:09 +0100
Message-ID: <51A11399.3090709@ramsay1.demon.co.uk>
References: <519BC8AF.8060804@ramsay1.demon.co.uk> <CANeU7Qkv7UkmFnQ__6q5zRkM8CTAUhwWhronFh-c70GLz-Q7QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:39449 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757816Ab3EYUFA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 25 May 2013 16:05:00 -0400
In-Reply-To: <CANeU7Qkv7UkmFnQ__6q5zRkM8CTAUhwWhronFh-c70GLz-Q7QA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Christopher Li wrote:
> On Tue, May 21, 2013 at 12:19 PM, Ramsay Jones
> <ramsay@ramsay1.demon.co.uk> wrote:
>> +       add_pre_buffer("extern int __sync_lock_test_and_set(volatile long *const, const long);\n");
> 
> Looking at the gcc documents about atomic builtins.  quote:
> "and further that they are overloaded such that they work on multiple types"
> 

Ah, yes, I obviously didn't investigate this carefully enough! :(
OK, so we can forget about this patch.

Thanks!

ATB,
Ramsay Jones



