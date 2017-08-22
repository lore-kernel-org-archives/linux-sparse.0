From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse parsing question - iterator statements
Date: Tue, 22 Aug 2017 11:02:43 -0400
Message-ID: <CANeU7QmzODQwr8PERtyRqmoK+91b9Z5kg-guTkwTPwybRJJGXA@mail.gmail.com>
References: <CACXZuxfWQHzHs1gps6SPPKvX53HUwVfEeca=sJPatKg39GF-8w@mail.gmail.com>
 <CANeU7Qk6gOS8u-AZy3rujav=z-TiVf69HXNX4jL2b6FFLaxfNg@mail.gmail.com> <CACXZuxdKSnt0SW=vS0w=c7WUkFKSV7F8kn6WZQJo+6dXz1vtbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:35715 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932329AbdHVPCp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Aug 2017 11:02:45 -0400
Received: by mail-yw0-f179.google.com with SMTP id s187so24390009ywf.2
        for <linux-sparse@vger.kernel.org>; Tue, 22 Aug 2017 08:02:44 -0700 (PDT)
In-Reply-To: <CACXZuxdKSnt0SW=vS0w=c7WUkFKSV7F8kn6WZQJo+6dXz1vtbA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 22, 2017 at 10:51 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> Except that the if (!) / break is implicit?

It is the same why if_statement works. if _statement has
if_condition. The iterator_staemement has two conditions.
Pre_condition and post_condition.

It is not more implicit than the if_condition in the if _condition.
>>        if (!post_condition())
>>                 break;
>
> And here too?

Same here.

Chris
