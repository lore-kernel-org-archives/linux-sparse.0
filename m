From: Christopher Li <sparse@chrisli.org>
Subject: Re: master merge plans
Date: Tue, 22 Aug 2017 11:51:55 -0400
Message-ID: <CANeU7Qm+LOCG2B7HXBbwsvCLR7bipHTH6nnkXtN7ruR8pNW6bA@mail.gmail.com>
References: <CANeU7Q=9nUo+D3R3ypCS=-kND2vD_Qx84ua59_bi0-VGftPuqA@mail.gmail.com>
 <CAExDi1QryT9Hc6+yY0_E4Y6opsq3JiYo0KOidSDSj4VGD0J1Nw@mail.gmail.com> <CANeU7QkQR6b936UR3VoYuzLGYdiOcTM=SaWtifsRNeF0rKhP+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:36695 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751909AbdHVPv4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Aug 2017 11:51:56 -0400
Received: by mail-yw0-f174.google.com with SMTP id y64so25873848ywf.3
        for <linux-sparse@vger.kernel.org>; Tue, 22 Aug 2017 08:51:56 -0700 (PDT)
In-Reply-To: <CANeU7QkQR6b936UR3VoYuzLGYdiOcTM=SaWtifsRNeF0rKhP+g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 22, 2017 at 10:47 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Tue, Aug 22, 2017 at 9:32 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>
>> Nicolai's constexpr series.
>>
>
> Is that constexpr-v4 branch on your git repository you want me to merge?

There might be a tiny bit slow down due to the constexpr. I will run more test
to see if I can ping point it. The last 3 group in each test was start by
a script. To be continue on this. The current number is not conclusive.

================ master merge constexpr-v4====================
1202.35user 446.83system 1:16.27elapsed 2162%CPU (0avgtext+0avgdata
238104maxresident)k
352inputs+12768outputs (0major+128889305minor)pagefaults 0swaps
1204.87user 447.25system 1:16.28elapsed 2165%CPU (0avgtext+0avgdata
238080maxresident)k
0inputs+12768outputs (0major+128888977minor)pagefaults 0swaps
1202.92user 447.03system 1:16.42elapsed 2158%CPU (0avgtext+0avgdata
238048maxresident)k
0inputs+12768outputs (0major+128888805minor)pagefaults 0swaps
1206.48user 446.75system 1:16.36elapsed 2164%CPU (0avgtext+0avgdata
238072maxresident)k
0inputs+12768outputs (0major+128888959minor)pagefaults 0swaps
1207.37user 447.35system 1:16.57elapsed 2161%CPU (0avgtext+0avgdata
238072maxresident)k
0inputs+12768outputs (0major+128888909minor)pagefaults 0swaps


1204.73user 446.87system 1:16.39elapsed 2161%CPU (0avgtext+0avgdata
238040maxresident)k
0inputs+12776outputs (0major+128889143minor)pagefaults 0swaps
1205.96user 447.91system 1:16.39elapsed 2164%CPU (0avgtext+0avgdata
238080maxresident)k
0inputs+12768outputs (0major+128889529minor)pagefaults 0swaps
1207.49user 448.00system 1:16.37elapsed 2167%CPU (0avgtext+0avgdata
238044maxresident)k
0inputs+12784outputs (0major+128888947minor)pagefaults 0swaps


================ rc5 =====================================
1201.56user 448.22system 1:16.24elapsed 2163%CPU (0avgtext+0avgdata
238048maxresident)k
0inputs+12768outputs (0major+128883583minor)pagefaults 0swaps
1203.27user 447.90system 1:16.22elapsed 2166%CPU (0avgtext+0avgdata
238036maxresident)k
0inputs+12768outputs (0major+128882925minor)pagefaults 0swaps
1201.65user 448.79system 1:16.20elapsed 2165%CPU (0avgtext+0avgdata
238044maxresident)k
0inputs+12768outputs (0major+128883529minor)pagefaults 0swaps

1202.19user 448.79system 1:16.24elapsed 2165%CPU (0avgtext+0avgdata
238192maxresident)k
0inputs+12768outputs (0major+128883477minor)pagefaults 0swaps
1203.38user 449.73system 1:16.33elapsed 2165%CPU (0avgtext+0avgdata
238044maxresident)k
0inputs+12776outputs (0major+128883089minor)pagefaults 0swaps
1203.37user 449.05system 1:16.23elapsed 2167%CPU (0avgtext+0avgdata
238080maxresident)k
0inputs+12768outputs (0major+128883199minor)pagefaults 0swaps

Chris
