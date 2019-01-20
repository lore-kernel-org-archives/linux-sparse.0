From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 1/4] include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR
Date: Sun, 20 Jan 2019 09:43:11 -0500
Message-ID: <20190120094237-mutt-send-email-mst@kernel.org>
References: <20190102205715.14054-1-mst@redhat.com>
 <20190102205715.14054-2-mst@redhat.com>
 <CAKwvOdk3b6mnpTEEyY-JFrej8K12w9oTMLqi7q5aNiRMyJo6Ow@mail.gmail.com>
 <CANiq72nEiw8+cZNnBOwF1ehv232ZJe5qzhdbaTEg0rOoV2p4sg@mail.gmail.com>
 <20190109094959-mutt-send-email-mst@kernel.org>
 <CANiq72npFGsoHmBQUSNRLohDmMBNQFka8AcmhMz--QU1v2Aorg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANiq72npFGsoHmBQUSNRLohDmMBNQFka8AcmhMz--QU1v2Aorg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, LKML <linux-kernel@vger.kernel.org>, Jason Wang <jasowang@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <andrea.parri@amarulasolutions.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org, Network Development <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, Eli Friedman <efriedma@codeaurora.org>
List-Id: linux-sparse@vger.kernel.org

On Sat, Jan 19, 2019 at 07:35:33PM +0100, Miguel Ojeda wrote:
> Hi Michael,
> 
> On Wed, Jan 9, 2019 at 3:50 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jan 09, 2019 at 11:35:52AM +0100, Miguel Ojeda wrote:
> > > Note it would be nice to separate the patch into two (one for the
> > > comments, another for OPTIMIZER_HIDE_VAR), and also possibly another
> > > for barrier_data().
> >
> > Okay, I will try.
> 
> Did you have a chance to do it (or maybe I missed the patches)? If
> not, no worries, I can send this to Linus as it is and get it in
> already, then we can do the barrier_data later.
> 
> Cheers,
> Miguel

No not yet. Sorry! Pls send this one in, barrier_data will likely miss
the next merge window.

-- 
MSR
