From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Fri, 7 Jul 2017 02:54:00 -0700
Message-ID: <CANeU7Q=6oqYf1wtcyK86ueEkpKw=c1acN2r45KzXon9y+dMpCQ@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com> <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
 <CA+55aFyUN-anJrFmo25tATO2wJS8+24S8TK=PAZBEYr0LvZN8g@mail.gmail.com>
 <CANeU7Q=XzVrNoUOScCJjtautBsc0ittc_Okh+0wESuV4rRqing@mail.gmail.com>
 <20170707082802.gphim2wpqsncqoyh@ltop.local> <CANeU7Qk3s90N35co_HOT0vfHhZDjthMv5=5dT9Hy72JQFfc=ng@mail.gmail.com>
 <20170707093008.4w5crwbevnzticmq@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35972 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752459AbdGGJyC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 05:54:02 -0400
Received: by mail-pf0-f182.google.com with SMTP id q86so14821607pfl.3
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 02:54:01 -0700 (PDT)
In-Reply-To: <20170707093008.4w5crwbevnzticmq@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jul 7, 2017 at 2:30 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Yes, it's very possible that it will work properly, but at which price?
> You will need to add some complexity to make it work, is it worth?

We will see. I think it is clean enough I will take a try.
The price is my time and other's who will need to review it.



> Except for the added complexity of having to maintain the ref count
> for, IMO, no good enough reasons, the problem is that some lists
> contains NULL pointers as legitimate values (I don't remember which

I guess we will find out. It is not hard to assert of NULL add to the
ptrlist. I do have ways to allow any value in entry but add more complexity.
Doing the correct thing is first priority.

If we are talking about the run time cost, I double it will make much of
the difference. We can benchmark for it.

Chris
