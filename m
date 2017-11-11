From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/2] Fix illegal simplification of volatile stores
Date: Sun, 12 Nov 2017 01:29:08 +0800
Message-ID: <CANeU7QnJgGdWtM3KkJOtWG72v_soBZfeXGkqMUmQcv-L=NM5oQ@mail.gmail.com>
References: <20171111162500.69476-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:44889 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751690AbdKKR3J (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 12:29:09 -0500
Received: by mail-yw0-f169.google.com with SMTP id k191so2096526ywe.1
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 09:29:09 -0800 (PST)
In-Reply-To: <20171111162500.69476-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Nov 12, 2017 at 12:24 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This series inhibit the illegal simplification of redundant
> stores when the stores are volatiles ones.
>
> Luc Van Oostenryck (2):
>   add test case for bogus volatile simplification
>   fix: volatile stores must not be simplified

Looks good to me.

Can I apply those?

Chris
