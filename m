From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: sparse: __pure declaration only
Date: Fri, 18 Oct 2019 12:15:22 +0100
Message-ID: <09d824ac-5371-830e-466d-7f78ccdae065@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-sparse@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

I'm seeing the following sparse warnings where the declaration
has __pure but the implementation does not.

> lib/bitmap.c:62:6: error: symbol '__bitmap_or_equal' redeclared with different type (originally declared at ./include/linux/bitmap.h:123) - different modifiers

is this a valid warning? if not, should sparse be ignoring these.

Note:
> include/linux/bitmap.h:extern bool __pure __bitmap_or_equal(const unsigned long *src1,
> lib/bitmap.c:bool __bitmap_or_equal(const unsigned long *bitmap1,


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
