From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: detecting misuse of of_get_property
Date: Tue, 29 Oct 2019 08:24:32 +0100
Message-ID: <2dcd6ac3-8a01-a11c-3532-5a8eb83ccdf5@rasmusvillemoes.dk>
References: <ec277c12-c608-6326-7723-be8cab4f524a@rasmusvillemoes.dk>
 <20191028224914.enpqjkcvbxyeexnl@desk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191028224914.enpqjkcvbxyeexnl@desk.local>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.co>, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On 28/10/2019 23.49, Luc Van Oostenryck wrote:
> On Mon, Oct 28, 2019 at 08:32:42PM +0100, Rasmus Villemoes wrote:
>> Hi,
>>
>> I just spent some time trying to convert some so far PPC-only drivers to
>> be more generic. One of the things I had to do was convert stuff like
>>
>>   u32 *val = of_get_property(np, "bla", NULL);
>>   do_stuff_with(*val);
>>
>> with
>>
>>   of_property_read_u32(np, "bla", &val);
>>   do_stuff_with(val);
>>
>> (error checking omitted for simplicity). The problem is that
>> of_get_property() just returns void*. When the property is just a
>> string, there's no problem interpreting that as a char*. But when the
>> property is a number of array of numbers, I'd like some way to flag
>> casting it to u32* as an error - if you cast it to a (pointer to integer
>> type wider than char), it must be to a __be32*. Is there some way
>> sparse/smatch could help find such cases?
> 
> If I understand you correctly, you would need a kind of 'soft'
> bitwise pointer?

Yes, that's a very good way of putting it.

> I guess it shouldn't be too hard to add a new flag which would
> allow cast of bitwise pointers to pointers to char/void (see
> at end of evaluate.c:evaluate_cast()).

Hm, yeah, but it should also allow casting to __be32* , but not u32* or
__le32* (though somebody must have gone out of their way to introduce a
bug in the latter case). Don't spend too much time on it, I was just
wondering if there was an easy (maybe already existing) way.

Thanks,
Rasmus
