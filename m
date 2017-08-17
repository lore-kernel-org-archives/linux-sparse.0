From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH 09/29] add helper to test if a variable is "simple"
Date: Thu, 17 Aug 2017 20:21:47 +0100
Message-ID: <CACXZuxd4FLJ7h7jeyi_NL8eDseciidShLX7xWMmF84bOBLxmVg@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-10-luc.vanoostenryck@gmail.com> <CANeU7QmU30Oafe5Peq6D5tnfBE+k=T+tttt3_vV0MeDGbbTZxQ@mail.gmail.com>
 <CACXZuxfQejAOR-JwSh+tYtjBgr3wYawVgEFNAXRU6c_QoTQKRA@mail.gmail.com> <CAExDi1SBiBWPO8RzfbxDbEnqaDTqO=EFX9HmjB+BjsaW75Ccbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:34064 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbdHQTVs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 15:21:48 -0400
Received: by mail-ua0-f172.google.com with SMTP id q25so28361366uah.1
        for <linux-sparse@vger.kernel.org>; Thu, 17 Aug 2017 12:21:47 -0700 (PDT)
In-Reply-To: <CAExDi1SBiBWPO8RzfbxDbEnqaDTqO=EFX9HmjB+BjsaW75Ccbw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Luc,

On 17 August 2017 at 20:17, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Aug 17, 2017 at 6:59 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> Apart from that I faced a problem with this and had to disable
>> STRUCT/UNION from being treated as simple types.
>
> That's only a problem/a limitation of your backend.
>

Possibly - I haven't checked yet. Are you able to generate code / and
run the test case using your LLVM backend?

Regards
Dibyendu
