From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: detecting misuse of of_get_property
Date: Mon, 28 Oct 2019 23:49:15 +0100
Message-ID: <20191028224914.enpqjkcvbxyeexnl@desk.local>
References: <ec277c12-c608-6326-7723-be8cab4f524a@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ec277c12-c608-6326-7723-be8cab4f524a@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Dan Carpenter <dan.carpenter@oracle.co>, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Mon, Oct 28, 2019 at 08:32:42PM +0100, Rasmus Villemoes wrote:
> Hi,
> 
> I just spent some time trying to convert some so far PPC-only drivers to
> be more generic. One of the things I had to do was convert stuff like
> 
>   u32 *val = of_get_property(np, "bla", NULL);
>   do_stuff_with(*val);
> 
> with
> 
>   of_property_read_u32(np, "bla", &val);
>   do_stuff_with(val);
> 
> (error checking omitted for simplicity). The problem is that
> of_get_property() just returns void*. When the property is just a
> string, there's no problem interpreting that as a char*. But when the
> property is a number of array of numbers, I'd like some way to flag
> casting it to u32* as an error - if you cast it to a (pointer to integer
> type wider than char), it must be to a __be32*. Is there some way
> sparse/smatch could help find such cases?

If I understand you correctly, you would need a kind of 'soft'
bitwise pointer?
I guess it shouldn't be too hard to add a new flag which would
allow cast of bitwise pointers to pointers to char/void (see
at end of evaluate.c:evaluate_cast()).

Note: casts from bitwise pointer to void* are already allowed.

-- Luc
