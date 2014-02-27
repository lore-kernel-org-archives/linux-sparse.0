From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V2] sparse: Allow override of sizeof(bool) warning
Date: Wed, 26 Feb 2014 20:19:57 -0800
Message-ID: <530EBCED.9020705@zytor.com>
References: <530E6F76.1070605@zytor.com> <1393462087.24588.50.camel@joe-AO722> <530E8C2E.7080307@zytor.com> <1393466619.24588.65.camel@joe-AO722> <20140227022857.GC23659@thin> <1393469594.24588.71.camel@joe-AO722> <20140227025845.GA25145@thin> <530EB103.5070406@zytor.com> <1393472326.24588.82.camel@joe-AO722> <20140227040050.GA8449@nicira.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140227040050.GA8449@nicira.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Pfaff <blp@nicira.com>, Joe Perches <joe@perches.com>
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On 02/26/2014 08:00 PM, Ben Pfaff wrote:
> 
> The commit *relaxed* sparse behavior: because previously sizeof(bool)
> was an error.  I'm not in favor of any diagnostic at all for
> sizeof(bool), but my recollection is that a sparse maintainer wanted it
> to yield one.
> 

Still not clear as to why.

	-hpa
