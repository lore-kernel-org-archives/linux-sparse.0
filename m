From: "Russ Cox" <rsc@swtch.com>
Subject: Re: [PATCH] Add const to pointer qualifiers for __chk_user_ptr and __chk_io_ptr.
Date: Mon, 26 Mar 2007 14:59:39 -0400
Message-ID: <ee9e417a0703261159g6aeed343t58a98c5f45141c53@mail.gmail.com>
References: <ee9e417a0703260823k55c6de8ay715be1db11692355@mail.gmail.com>
	 <20070326180155.GA24764@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753698AbXCZS7m@vger.kernel.org>
In-Reply-To: <20070326180155.GA24764@chrisli.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On 3/26/07, Christopher Li <sparse@chrisli.org> wrote:
> On Mon, Mar 26, 2007 at 11:23:56AM -0400, Russ Cox wrote:
> > Change prototypes for  __chk_user_ptr and __chk_io_ptr
> > to take const void* instead of void*, so that code can pass
> > const void* to them.  (Right now sparse does not warn
> > about passing const void* to void* functions, but that
> > is a separate bug that I believe Josh is working on,
> > and once sparse does check this, the changed prototypes
> > will be necessary.)
>
> I don't think it is needed. The __user has noderef attribute.
> Which means it is not allow to dereference the pointer. The
> const qualifier allow read dereference, only write is not allowed.
>
> Adding const here will likely force the caller to do a cast at
> the pointer arguments. Which defeats the checker.

No, you have it backward.
It is valid to pass void* to a const void* function.
It is *not* valid to pass const void* to a void* function.

Right now __chk_user_ptr is a void* function, meaning
that all the places where it gets passed a const void*
are technically illegal -- gcc would warn about these, and
it is a (separate, as you observed) bug that sparse does not.

The patch changes __chk_user_ptr to be a const void*
function, meaning that it will be legal to pass either void*
or const void* to it.  This is the correct semantics.

Russ
