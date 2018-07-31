From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH v4 13/17] khwasan: add hooks implementation
Date: Tue, 31 Jul 2018 17:50:00 +0300
Message-ID: <8240d4f9-c8df-cfe9-119d-6e933f8b13df@virtuozzo.com>
References: <cover.1530018818.git.andreyknvl@google.com>
 <a2a93370d43ec85b02abaf8d007a15b464212221.1530018818.git.andreyknvl@google.com>
 <09cb5553-d84a-0e62-5174-315c14b88833@arm.com>
 <CAAeHK+yC3XRPoTByhH1QPrX45pG3QY_2Q4gz=dfDgxfzu1Fyfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAeHK+yC3XRPoTByhH1QPrX45pG3QY_2Q4gz=dfDgxfzu1Fyfw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>, vincenzo.frascino@arm.com
Cc: Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@l>
List-Id: linux-sparse@vger.kernel.org



On 07/31/2018 04:05 PM, Andrey Konovalov wrote:
> On Wed, Jul 25, 2018 at 3:44 PM, Vincenzo Frascino@Foss
> <vincenzo.frascino@arm.com> wrote:
>> On 06/26/2018 02:15 PM, Andrey Konovalov wrote:
>>
>>> @@ -325,18 +341,41 @@ void kasan_init_slab_obj(struct kmem_cache *cache,
>>> const void *object)
>>>     void *kasan_slab_alloc(struct kmem_cache *cache, void *object, gfp_t
>>> flags)
>>>   {
>>> -       return kasan_kmalloc(cache, object, cache->object_size, flags);
>>> +       object = kasan_kmalloc(cache, object, cache->object_size, flags);
>>> +       if (IS_ENABLED(CONFIG_KASAN_HW) && unlikely(cache->ctor)) {
>>> +               /*
>>> +                * Cache constructor might use object's pointer value to
>>> +                * initialize some of its fields.
>>> +                */
>>> +               cache->ctor(object);
>>>
>> This seams breaking the kmem_cache_create() contract: "The @ctor is run when
>> new pages are allocated by the cache."
>> (https://elixir.bootlin.com/linux/v3.7/source/mm/slab_common.c#L83)
>>
>> Since there might be preexisting code relying on it, this could lead to
>> global side effects. Did you verify that this is not the case?
>>
>> Another concern is performance related if we consider this solution suitable
>> for "near-production", since with the current implementation you call the
>> ctor (where present) on an object multiple times and this ends up memsetting
>> and repopulating the memory every time (i.e. inode.c: inode_init_once). Do
>> you know what is the performance impact?
> 
> We can assign tags to objects with constructors when a slab is
> allocated and call constructors once as usual. The downside is that
> such object would always have the same tag when it is reallocated, so
> we won't catch use-after-frees. 

Actually you should do this for SLAB_TYPESAFE_BY_RCU slabs. Usually they are with ->ctors but there
are few without constructors.
We can't reinitialize or even retag them. The latter will definitely cause false-positive use-after-free reports.

As for non-SLAB_TYPESAFE_BY_RCU caches with constructors, it's probably ok to reinitialize and retag such objects.
I don't see how could any code rely on the current ->ctor() behavior in non-SLAB_TYPESAFE_BY_RCU case,
unless it does something extremely stupid or weird.
But let's not do it now. If you care, you cand do it later, with a separate patch, so we could just revert
it if anything goes wrong.
