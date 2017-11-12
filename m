From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [GIT PULL] llvm fixes
Date: Sun, 12 Nov 2017 06:45:52 +0100
Message-ID: <20171112054550.cppako2mchvyhmmg@ltop.local>
References: <20170918095135.12066-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qnu7h09YHhGVOY3r4M9FNOvOrs+kB_yJT-i0cSeLtKhAw@mail.gmail.com>
 <CANeU7QnFkJC4YePAdSTmKXNKiraCZHKJPSaNbKVPqdf01NhrYg@mail.gmail.com>
 <20171105171013.mktkihyuuagqthaq@ltop.local>
 <CANeU7QkXyUonK-wKjrGp_Ka6vBsFaJ65S3OvjMzLTKc8VUoW4w@mail.gmail.com>
 <CANeU7Q=qa4Je13z65nHa_V=QAC4w-30GiO3e72Lp5C49QYcDVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33538 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbdKLFp5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Nov 2017 00:45:57 -0500
Received: by mail-wm0-f65.google.com with SMTP id r68so10237151wmr.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 21:45:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=qa4Je13z65nHa_V=QAC4w-30GiO3e72Lp5C49QYcDVg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Nov 12, 2017 at 09:04:43AM +0800, Christopher Li wrote:
> - create special instruction that is not part of bb->insns. Push
> instruction in insn.arguments.

You already came with this previously and I already replied you about it.
I don't know what make you think that OP_PUSH are not in bb->insns
but you're wrong: they are normal instructions and are thus stored
in the bb->insns, the second patch even change their position inside
this list.


-- Luc
