From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH sparse] parse: shifting by full number of bits is
 undefined
Date: Fri, 26 Oct 2018 11:01:37 +0200
Message-ID: <20181026090136.2fidq6kicv4szwjd@ltop.local>
References: <CAHmME9oZk7Afns=W=xM=6waqvVfV+iAdAcB6731xzUUcm4P0zA@mail.gmail.com>
 <20181026031700.12310-1-Jason@zx2c4.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181026031700.12310-1-Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Fri, Oct 26, 2018 at 05:17:00AM +0200, Jason A. Donenfeld wrote:
> The type checker wasn't identifying upper bounds for huge unsigned
> 64-bit numbers, because the right shift turned into a no-op:
> 
> zx2c4@thinkpad /tmp $ cat sparse.c
> enum { sparse_does_not_like_this = 0x8000000000000003ULL };
> zx2c4@thinkpad /tmp $ sparse sparse.c
> sparse.c:1:36: warning: cast truncates bits from constant value (8000000000000003 becomes 3)

Hi Jason,

This is already fixed in the development tree:
   git://github.com/lucvoo/sparse.git
together with some other fixes & changes regarding enums.

I hope to be able to push this to the official tree real soon now.


Kind regards,
-- Luc
