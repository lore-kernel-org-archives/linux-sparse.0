From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse: __pure declaration only
Date: Sun, 20 Oct 2019 07:52:53 +0200
Message-ID: <20191020055252.2ymxfrskpodxhuxs@ltop.local>
References: <09d824ac-5371-830e-466d-7f78ccdae065@codethink.co.uk>
 <CAHk-=wiYQ=F5H-uwQvj4eMS3xREmqE6tPuDVVLVML02xaThqVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=wiYQ=F5H-uwQvj4eMS3xREmqE6tPuDVVLVML02xaThqVQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Fri, Oct 18, 2019 at 08:31:48AM -0700, Linus Torvalds wrote:
> On Fri, Oct 18, 2019 at 4:15 AM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> >
> > is this a valid warning? if not, should sparse be ignoring these.
> 
> It's technically valid, but maybe it's not useful.
> 
> If we make sure that any pure bits from a declaration always make it
> into the definition, then I suspect that the "was not declared"
> warning (if the definition is non-static and seen without a
> declaration) is sufficient.
> 
> Of course, sparse doesn't actually _care_ about "pure" in the
> definition, only in the use, so right now it doesn't even make any
> difference to sparse whether the definition has the "pure" or not.
> It's only when the function is used that the "pure" matters (it makes
> the call instruction be CSE'd like any other random instruction).

Yes, for 'pure' it doesn't matter much but it's a problem anyway.
For example with 'static':

$ cat file.c
static void foo(void);
void foo(void) { }

$ sparse file.c
file.c:2:6: warning: symbol 'foo' was not declared. Should it be static?

Which is kinda absurd: foo() was declared and was even declared static.
But the definition is a different symbol than its declaration (OK) which
doesn't 'inherit' the declaration's specifier/modifier/attributes.
It's on my to-be-fixed list for a long time but ..

-- Luc
