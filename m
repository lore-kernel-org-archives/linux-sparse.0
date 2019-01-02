From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RFC 3/4] barriers: convert a control to a data dependency
Date: Wed, 2 Jan 2019 13:00:24 -0800
Message-ID: <20190102210024.GJ6310@bombadil.infradead.org>
References: <20190102205715.14054-1-mst@redhat.com>
 <20190102205715.14054-4-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190102205715.14054-4-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <andrea.parri@amarulasolutions.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Jonathan Corbet <corbet@lwn.net>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst>
List-Id: linux-sparse@vger.kernel.org

On Wed, Jan 02, 2019 at 03:57:58PM -0500, Michael S. Tsirkin wrote:
> @@ -875,6 +893,8 @@ to the CPU containing it.  See the section on "Multicopy atomicity"
>  for more information.
>  
>  
> +
> +
>  In summary:
>  
>    (*) Control dependencies can order prior loads against later stores.

Was this hunk intentional?
