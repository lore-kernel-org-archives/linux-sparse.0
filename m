From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: detecting misuse of of_get_property
Date: Mon, 28 Oct 2019 20:32:42 +0100
Message-ID: <ec277c12-c608-6326-7723-be8cab4f524a@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dan Carpenter <dan.carpenter@oracle.co>
Cc: linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

Hi,

I just spent some time trying to convert some so far PPC-only drivers to
be more generic. One of the things I had to do was convert stuff like

  u32 *val = of_get_property(np, "bla", NULL);
  do_stuff_with(*val);

with

  of_property_read_u32(np, "bla", &val);
  do_stuff_with(val);

(error checking omitted for simplicity). The problem is that
of_get_property() just returns void*. When the property is just a
string, there's no problem interpreting that as a char*. But when the
property is a number of array of numbers, I'd like some way to flag
casting it to u32* as an error - if you cast it to a (pointer to integer
type wider than char), it must be to a __be32*. Is there some way
sparse/smatch could help find such cases?

Rasmus
