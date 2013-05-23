From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 5/5] lib.c: Add __sync_lock_test_and_set as a builtin function
Date: Wed, 22 May 2013 20:15:44 -0700
Message-ID: <CANeU7Qkv7UkmFnQ__6q5zRkM8CTAUhwWhronFh-c70GLz-Q7QA@mail.gmail.com>
References: <519BC8AF.8060804@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:56662 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346Ab3EWDPp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 May 2013 23:15:45 -0400
Received: by mail-oa0-f44.google.com with SMTP id n12so3764798oag.17
        for <linux-sparse@vger.kernel.org>; Wed, 22 May 2013 20:15:45 -0700 (PDT)
In-Reply-To: <519BC8AF.8060804@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Tue, May 21, 2013 at 12:19 PM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
> +       add_pre_buffer("extern int __sync_lock_test_and_set(volatile long *const, const long);\n");

Looking at the gcc documents about atomic builtins.  quote:
"and further that they are overloaded such that they work on multiple types"

Sparse does not do type overload. Which means sparse can't properly support this
function right now. If some one try to use this function on an int
type, sparse will
complain about type mismatch.

Chris
