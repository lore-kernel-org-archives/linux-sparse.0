From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: master merge plans
Date: Tue, 22 Aug 2017 22:05:27 +0200
Message-ID: <CAMHZB6Hiqca+zi5eX8jN_-v9nZ3Cv2DwkW9isjyOSuUdvEnf6Q@mail.gmail.com>
References: <CANeU7Q=9nUo+D3R3ypCS=-kND2vD_Qx84ua59_bi0-VGftPuqA@mail.gmail.com>
 <CAExDi1QryT9Hc6+yY0_E4Y6opsq3JiYo0KOidSDSj4VGD0J1Nw@mail.gmail.com>
 <CANeU7QkQR6b936UR3VoYuzLGYdiOcTM=SaWtifsRNeF0rKhP+g@mail.gmail.com> <CANeU7Qm+LOCG2B7HXBbwsvCLR7bipHTH6nnkXtN7ruR8pNW6bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36178 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752362AbdHVUF2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Aug 2017 16:05:28 -0400
Received: by mail-vk0-f53.google.com with SMTP id u133so62777499vke.3
        for <linux-sparse@vger.kernel.org>; Tue, 22 Aug 2017 13:05:28 -0700 (PDT)
In-Reply-To: <CANeU7Qm+LOCG2B7HXBbwsvCLR7bipHTH6nnkXtN7ruR8pNW6bA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 22, 2017 at 5:51 PM, Christopher Li <sparse@chrisli.org> wrote:
>>
>> Is that constexpr-v4 branch on your git repository you want me to merge?

Yes.

> There might be a tiny bit slow down due to the constexpr. I will run more test
> to see if I can ping point it. The last 3 group in each test was start by
> a script. To be continue on this. The current number is not conclusive.

At worse these numbers show something like 0.1-0.3%.

-- Luc
