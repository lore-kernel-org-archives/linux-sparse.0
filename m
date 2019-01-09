From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH RFC 1/4] include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR
Date: Wed, 9 Jan 2019 11:35:52 +0100
Message-ID: <CANiq72nEiw8+cZNnBOwF1ehv232ZJe5qzhdbaTEg0rOoV2p4sg@mail.gmail.com>
References: <20190102205715.14054-1-mst@redhat.com> <20190102205715.14054-2-mst@redhat.com>
 <CAKwvOdk3b6mnpTEEyY-JFrej8K12w9oTMLqi7q5aNiRMyJo6Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKwvOdk3b6mnpTEEyY-JFrej8K12w9oTMLqi7q5aNiRMyJo6Ow@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Jason Wang <jasowang@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <andrea.parri@amarulasolutions.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org, Network Development <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, Eli Friedman <efriedma@codeaurora.org>, Joe Perches <joe@p>
List-Id: linux-sparse@vger.kernel.org

On Tue, Jan 8, 2019 at 6:44 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Also for more context, see:
> commit 7829fb09a2b4 ("lib: make memzero_explicit more robust against
> dead store elimination")

By the way, shouldn't that barrier_data() be directly in compiler.h
too, since it is for both gcc & clang?

> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> + Miguel
> Miguel, would you mind taking this into your compiler-attributes tree?

Sure, at least we get quickly some linux-next time.

Note it would be nice to separate the patch into two (one for the
comments, another for OPTIMIZER_HIDE_VAR), and also possibly another
for barrier_data().

Cheers,
Miguel
