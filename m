From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Query: why do the ptr_list subtypes have a different structure?
Date: Fri, 11 Aug 2017 12:49:11 +0200
Message-ID: <20170811104910.4kox757d3hofzx5d@ltop.local>
References: <CACXZuxfL7h3XWeWAQ6+pBpuWTQjSwyQLo8BNtF+nWUZ754kWEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36175 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbdHKKtP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 11 Aug 2017 06:49:15 -0400
Received: by mail-wm0-f53.google.com with SMTP id t201so38916810wmt.1
        for <linux-sparse@vger.kernel.org>; Fri, 11 Aug 2017 03:49:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxfL7h3XWeWAQ6+pBpuWTQjSwyQLo8BNtF+nWUZ754kWEw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Aug 11, 2017 at 10:17:34AM +0100, Dibyendu Majumdar wrote:
> One thing that has puzzled me from the start is why the subtypes of
> ptr_list have a different structure. Is there a reason for that?

You're asking why struct ptr_list begin with :
	int nr;
	.. next;
	.. prev;
and then only:
	void *list[NR];

while the real lists are declared via DECLARE_PTR_LIST() as:
	struct ... *list[1];

right?

Only Linus can really answer to this but it seems that it is done
so simply so that directly dereferencing those lists will give
garbage as best, crashes most of the time to discourage.
The goal being to force the use of the macros/discourage to
directly access them, and so enforce the type checking.

-- Luc
