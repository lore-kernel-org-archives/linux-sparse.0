From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 1/4] include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR
Date: Thu, 10 Jan 2019 09:08:22 -0500
Message-ID: <20190110090804-mutt-send-email-mst@kernel.org>
References: <20190102205715.14054-1-mst@redhat.com>
 <20190102205715.14054-2-mst@redhat.com>
 <CAKwvOdk3b6mnpTEEyY-JFrej8K12w9oTMLqi7q5aNiRMyJo6Ow@mail.gmail.com>
 <CANiq72nEiw8+cZNnBOwF1ehv232ZJe5qzhdbaTEg0rOoV2p4sg@mail.gmail.com>
 <20190109213543-mutt-send-email-mst@kernel.org>
 <20190110134139.GE1743@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190110134139.GE1743@kadam>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, LKML <linux-kernel@vger.kernel.org>, Jason Wang <jasowang@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <andrea.parri@amarulasolutions.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org, Network Development <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, Eli
List-Id: linux-sparse@vger.kernel.org

On Thu, Jan 10, 2019 at 04:41:39PM +0300, Dan Carpenter wrote:
> On Wed, Jan 09, 2019 at 09:36:41PM -0500, Michael S. Tsirkin wrote:
> > On Wed, Jan 09, 2019 at 11:35:52AM +0100, Miguel Ojeda wrote:
> > > On Tue, Jan 8, 2019 at 6:44 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > >
> > > > Also for more context, see:
> > > > commit 7829fb09a2b4 ("lib: make memzero_explicit more robust against
> > > > dead store elimination")
> > > 
> > > By the way, shouldn't that barrier_data() be directly in compiler.h
> > > too, since it is for both gcc & clang?
> > > 
> > > > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > > >
> > > > + Miguel
> > > > Miguel, would you mind taking this into your compiler-attributes tree?
> > > 
> > > Sure, at least we get quickly some linux-next time.
> > 
> > 
> > BTW why linux-next? shouldn't this go into 5.0 and stable? It's a bugfix after all.
> > 
> 
> It doesn't hurt to put things in linux-next for a week and then 5.0 and
> -stable.  Not a lot of testing happens on linux-next, but some does.
> 
> regards,
> dan carpenter

I misunderstood. Sure that makes sense.

-- 
MST
