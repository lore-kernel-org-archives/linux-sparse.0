From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm incorrect type when ealing with union type
Date: Sun, 19 Mar 2017 16:37:34 +0000
Message-ID: <CACXZuxcSn=qPJF4S0SPmGr5xd64X6WevnwFcC+UuWPZPQ=odFQ@mail.gmail.com>
References: <CACXZuxcb=27brA9N=w-tnZ9V0StKnDYZ4y27cS6eoenA7S0ctw@mail.gmail.com>
 <20170319153609.yykbjbbb6v4lw4xb@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:36057 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbdCSQqB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 12:46:01 -0400
Received: by mail-it0-f45.google.com with SMTP id w124so67037891itb.1
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 09:46:00 -0700 (PDT)
In-Reply-To: <20170319153609.yykbjbbb6v4lw4xb@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 19 March 2017 at 15:36, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> This seems to be fixed in the llvm-fixes-v3 serie I submitted yesterday.
> But I never saw exactly what was the specific problem here.
>

I noticed that in the latest patch series for add/sub you are not
using GEP anymore, and there is a conversion to target type at the end
of a binary op. I will try out these changes and report back.

Thanks and Regards
Dibyendu
