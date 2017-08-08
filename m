From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2 6/8] transform (A & M) >> S to (A >> S) & (M >> S)
Date: Mon, 7 Aug 2017 21:48:33 -0400
Message-ID: <CANeU7QmdUz-FKVOdKy-J+fqpNU_tb_cNFkAjtiL8poiTVWFcNw@mail.gmail.com>
References: <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
 <20170807191205.86590-1-luc.vanoostenryck@gmail.com> <20170807191205.86590-7-luc.vanoostenryck@gmail.com>
 <CANeU7Q=VSGSTLweWegU1RxZO9_iV9UT0p9L5xe95rC6-vMuntA@mail.gmail.com> <CAExDi1RAaLD2aeCLBqcAngqKDuG5FpeOpZQP6TZ=Mo+MFBKwyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34506 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751930AbdHHBse (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 21:48:34 -0400
Received: by mail-pg0-f53.google.com with SMTP id u185so8459699pgb.1
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 18:48:34 -0700 (PDT)
In-Reply-To: <CAExDi1RAaLD2aeCLBqcAngqKDuG5FpeOpZQP6TZ=Mo+MFBKwyQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 7, 2017 at 8:29 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Tue, Aug 8, 2017 at 2:22 AM, Christopher Li <sparse@chrisli.org> wrote:
>
>> Why (A>>S) & (M >>S) is easier to simplify?
>>
>> The original has two instruction but the result has three.
>
> Only 2 because M & S are constants and so (M >> S) is already evaluated.

Ah, thanks for point it out the obvious. Your M means Mask.
I did not catch that.

Chris
