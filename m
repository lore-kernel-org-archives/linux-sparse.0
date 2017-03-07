From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 02/13] llvm: fix translation of PSEUDO_VALs into a ValueRefs
Date: Wed, 8 Mar 2017 06:48:08 +0800
Message-ID: <CANeU7Qn=9i2pC--do4OCBoxvQxjYbEe1Rv5ZZcK65Y061rLzBw@mail.gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
 <20170305112047.3411-3-luc.vanoostenryck@gmail.com> <CANeU7Q=tPmE4wuCw7MN4kyru_eTCOrGG-kDd6azq0JQkimQ17w@mail.gmail.com>
 <20170307161817.g7v5aihjjbhpweqs@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:34287 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933298AbdCGXqo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Mar 2017 18:46:44 -0500
Received: by mail-io0-f172.google.com with SMTP id g6so17006346ioj.1
        for <linux-sparse@vger.kernel.org>; Tue, 07 Mar 2017 15:45:43 -0800 (PST)
In-Reply-To: <20170307161817.g7v5aihjjbhpweqs@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Wed, Mar 8, 2017 at 12:18 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> We should fix the warning. Maybe combine the previous patch with this one?
>
> Yes, if you prefer so.
> Generally I prefer to separate the introduction of new code and its use
> but it doesn't really matter much.

I don't have a problem with separate new code vs using it. No big deal there.

It is the warning I want to get rid of.

Chris
