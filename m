From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse: ARRAY_SIZE and sparse array initialization
Date: Sun, 30 Mar 2014 10:16:22 -0700
Message-ID: <CANeU7QkxSMEvyiA7ua52cRPinwcZ+gDbEuJiD7BE+oOmA_2bUw@mail.gmail.com>
References: <532442E2.7050206@xs4all.nl>
	<532443AB.9080105@xs4all.nl>
	<533553E6.3060508@xs4all.nl>
	<CANeU7Qksj-tq0fjsZya1otX75sV4JOsAdXHr5Kxu-WyvYrksSw@mail.gmail.com>
	<533807FC.5050008@xs4all.nl>
	<CA+55aFy8y6ctXcc8qcqVkRDAL=ZWU0DAfuZ4zQcP6uqzPmb-AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <CA+55aFy8y6ctXcc8qcqVkRDAL=ZWU0DAfuZ4zQcP6uqzPmb-AA@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Sun, Mar 30, 2014 at 9:48 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> But then when we look up a symbol, we only look at the latest one, so
> when we size the array, we look at that "extern" declaration, and
> don't see the size that was created with the initializer.

Exactly. Sparse need to handle merging of incremental type declare.
This is a long known sparse bug.

>
> I'll think about how to fix it cleanly. Expect a patch shortly.

Wow, cool. I want to mention one special case of the type merging.
It has some thing to do with scoping as well. When the scope ends,
the incremental type added inside the scope will need to strip away
as well. So it can not be blindly add to the original type without consider
how to take that layer away later.

This should be very exciting. Looking forward to the patch.

Chris
