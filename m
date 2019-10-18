From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: sparse: __pure declaration only
Date: Fri, 18 Oct 2019 08:31:48 -0700
Message-ID: <CAHk-=wiYQ=F5H-uwQvj4eMS3xREmqE6tPuDVVLVML02xaThqVQ@mail.gmail.com>
References: <09d824ac-5371-830e-466d-7f78ccdae065@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <09d824ac-5371-830e-466d-7f78ccdae065@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Fri, Oct 18, 2019 at 4:15 AM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> is this a valid warning? if not, should sparse be ignoring these.

It's technically valid, but maybe it's not useful.

If we make sure that any pure bits from a declaration always make it
into the definition, then I suspect that the "was not declared"
warning (if the definition is non-static and seen without a
declaration) is sufficient.

Of course, sparse doesn't actually _care_ about "pure" in the
definition, only in the use, so right now it doesn't even make any
difference to sparse whether the definition has the "pure" or not.
It's only when the function is used that the "pure" matters (it makes
the call instruction be CSE'd like any other random instruction).

               Linus
