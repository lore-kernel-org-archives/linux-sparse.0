From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse: Why test-parse shows "+=" as a store?
Date: Mon, 27 Apr 2009 10:53:20 -0700
Message-ID: <70318cbf0904271053x3594cc46j7fec12f8ef624fcb@mail.gmail.com>
References: <49F4C99A.7020208@garzik.org>
	 <70318cbf0904262304j3d85f839o5fbd37d48f0e79e8@mail.gmail.com>
	 <49F588BA.4060503@garzik.org>
	 <70318cbf0904271045s6b2e300evad7f6ec05dd96b3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f166.google.com ([209.85.217.166]:38163 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbZD0RxZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 27 Apr 2009 13:53:25 -0400
Received: by gxk10 with SMTP id 10so117673gxk.13
        for <linux-sparse@vger.kernel.org>; Mon, 27 Apr 2009 10:53:23 -0700 (PDT)
In-Reply-To: <70318cbf0904271045s6b2e300evad7f6ec05dd96b3f@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-sparse@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

On Mon, Apr 27, 2009 at 10:45 AM, Christopher Li <sparse@chrisli.org> wrote:
>
> Let me take a look at your code as well. Maybe I can spot some thing.
>

s2l_gen_assignment does not look into the expr->op value.

When expr->op is '=' case, that is the general assign.
When expr->op is SPECIAL_ADD_ASSIGN, that is the add assign case.
You can take a look at linearize_assign function.


Chris
