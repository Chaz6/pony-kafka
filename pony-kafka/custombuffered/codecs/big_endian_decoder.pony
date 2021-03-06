/*

Copyright (C) 2016-2017, Sendence LLC
Copyright (C) 2016-2017, The Pony Developers
Copyright (c) 2014-2015, Causality Ltd.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/

use ".."
use "../../utils/bool_converter"
use "itertools"

primitive BigEndianDecoder
  fun u8(rb: Reader): U8 ? =>
    """
    Get a U8. Raise an error if there isn't enough data.
    """
    rb.read_byte()?

  fun bool(rb: Reader): Bool ? =>
    """
    Get a Bool. Raise an error if there isn't enough data.
    """
    BoolConverter.u8_to_bool(u8(rb)?)

  fun i8(rb: Reader): I8 ? =>
    """
    Get an I8.
    """
    u8(rb)?.i8()

  fun u16(rb: Reader): U16 ? =>
    """
    Get a big-endian U16.
    """
    let data = rb.read_bytes(2)?

    _decode_u16(consume data)? as U16

  fun _decode_u16(data: Array[U8] val): U16 ? =>
    (data(0)?.u16() << 8) or data(1)?.u16()

  fun _decode_u16(data: (Array[Array[U8] val] val | Array[Array[U8] iso] val)): U16 ? =>
    var out: U16 = 0
    let iters = Array[Iterator[U8]]
    match data
    | let arr: Array[Array[U8] val] val =>
      for a in arr.values() do
        iters.push(a.values())
      end
    | let arr: Array[Array[U8] iso] val =>
      for a in arr.values() do
        iters.push(a.values())
      end
    end
    let iter_all = Iter[U8].chain(iters.values())
    while iter_all.has_next() do
      out = (out << 8) or iter_all.next()?.u16()
    end
    return out

  fun i16(rb: Reader): I16 ? =>
    """
    Get a big-endian I16.
    """
    u16(rb)?.i16()

  fun u32(rb: Reader): U32 ? =>
    """
    Get a big-endian U32.
    """
    let data = rb.read_bytes(4)?

    _decode_u32(consume data)? as U32

  fun _decode_u32(data: Array[U8] val): U32 ? =>
    (data(0)?.u32() << 24) or (data(1)?.u32() << 16) or
    (data(2)?.u32() << 8) or data(3)?.u32()

  fun _decode_u32(data: (Array[Array[U8] val] val | Array[Array[U8] iso] val)): U32 ? =>
    var out: U32 = 0
    let iters = Array[Iterator[U8]]
    match data
    | let arr: Array[Array[U8] val] val =>
      for a in arr.values() do
        iters.push(a.values())
      end
    | let arr: Array[Array[U8] iso] val =>
      for a in arr.values() do
        iters.push(a.values())
      end
    end
    let iter_all = Iter[U8].chain(iters.values())
    while iter_all.has_next() do
      out = (out << 8) or iter_all.next()?.u32()
    end
    return out

  fun i32(rb: Reader): I32 ? =>
    """
    Get a big-endian I32.
    """
    u32(rb)?.i32()

  fun u64(rb: Reader): U64 ? =>
    """
    Get a big-endian U64.
    """
    let data = rb.read_bytes(8)?

    _decode_u64(consume data)? as U64

  fun _decode_u64(data: Array[U8] val): U64 ? =>
    (data(0)?.u64() << 56) or (data(1)?.u64() << 48) or
    (data(2)?.u64() << 40) or (data(3)?.u64() << 32) or
    (data(4)?.u64() << 24) or (data(5)?.u64() << 16) or
    (data(6)?.u64() << 8) or data(7)?.u64()

  fun _decode_u64(data: (Array[Array[U8] val] val | Array[Array[U8] iso] val)): U64 ? =>
    var out: U64 = 0
    let iters = Array[Iterator[U8]]
    match data
    | let arr: Array[Array[U8] val] val =>
      for a in arr.values() do
        iters.push(a.values())
      end
    | let arr: Array[Array[U8] iso] val =>
      for a in arr.values() do
        iters.push(a.values())
      end
    end
    let iter_all = Iter[U8].chain(iters.values())
    while iter_all.has_next() do
      out = (out << 8) or iter_all.next()?.u64()
    end
    return out

  fun i64(rb: Reader): I64 ? =>
    """
    Get a big-endian I64.
    """
    u64(rb)?.i64()


  fun u128(rb: Reader): U128 ? =>
    """
    Get a big-endian U128.
    """
    let data = rb.read_bytes(16)?

    _decode_u128(consume data)? as U128

  fun _decode_u128(data: Array[U8] val): U128 ? =>
    (data(0)?.u128() << 120) or (data(1)?.u128() << 112) or
    (data(2)?.u128() << 104) or (data(3)?.u128() << 96) or
    (data(4)?.u128() << 88) or (data(5)?.u128() << 80) or
    (data(6)?.u128() << 72) or (data(7)?.u128() << 64) or
    (data(8)?.u128() << 56) or (data(9)?.u128() << 48) or
    (data(10)?.u128() << 40) or (data(11)?.u128() << 32) or
    (data(12)?.u128() << 24) or (data(13)?.u128() << 16) or
    (data(14)?.u128() << 8) or data(15)?.u128()

  fun _decode_u128(data: (Array[Array[U8] val] val | Array[Array[U8] iso] val)): U128 ? =>
    var out: U128 = 0
    let iters = Array[Iterator[U8]]
    match data
    | let arr: Array[Array[U8] val] val =>
      for a in arr.values() do
        iters.push(a.values())
      end
    | let arr: Array[Array[U8] iso] val =>
      for a in arr.values() do
        iters.push(a.values())
      end
    end
    let iter_all = Iter[U8].chain(iters.values())
    while iter_all.has_next() do
      out = (out << 8) or iter_all.next()?.u128()
    end
    return out

  fun i128(rb: Reader): I128 ? =>
    """
    Get a big-endian I129.
    """
    u128(rb)?.i128()

  fun f32(rb: Reader): F32 ? =>
    """
    Get a big-endian F32.
    """
    F32.from_bits(u32(rb)?)

  fun f64(rb: Reader): F64 ? =>
    """
    Get a big-endian F64.
    """
    F64.from_bits(u64(rb)?)

  fun peek_u8(rb: PeekableReader box, offset: USize = 0): U8 ? =>
    """
    Peek at a U8 at the given offset. Raise an error if there isn't enough
    data.
    """
    rb.peek_byte(offset)?

  fun peek_i8(rb: PeekableReader box, offset: USize = 0): I8 ? =>
    """
    Peek at an I8.
    """
    peek_u8(rb, offset)?.i8()

  fun peek_u16(rb: PeekableReader box, offset: USize = 0): U16 ? =>
    """
    Peek at a big-endian U16.
    """
    let data = rb.peek_bytes(2, offset)?

    _decode_u16(data)? as U16

  fun peek_i16(rb: PeekableReader box, offset: USize = 0): I16 ? =>
    """
    Peek at a big-endian I16.
    """
    peek_u16(rb, offset)?.i16()

  fun peek_u32(rb: PeekableReader box, offset: USize = 0): U32 ? =>
    """
    Peek at a big-endian U32.
    """
    let data = rb.peek_bytes(4, offset)?

    _decode_u32(data)? as U32

  fun peek_i32(rb: PeekableReader box, offset: USize = 0): I32 ? =>
    """
    Peek at a big-endian I32.
    """
    peek_u32(rb, offset)?.i32()

  fun peek_u64(rb: PeekableReader box, offset: USize = 0): U64 ? =>
    """
    Peek at a big-endian U64.
    """
    let data = rb.peek_bytes(8, offset)?

    _decode_u64(data)? as U64

  fun peek_i64(rb: PeekableReader box, offset: USize = 0): I64 ? =>
    """
    Peek at a big-endian I64.
    """
    peek_u64(rb, offset)?.i64()

  fun peek_u128(rb: PeekableReader box, offset: USize = 0): U128 ? =>
    """
    Peek at a big-endian U128.
    """
    let data = rb.peek_bytes(16, offset)?

    _decode_u128(data)? as U128

  fun peek_i128(rb: PeekableReader box, offset: USize = 0): I128 ? =>
    """
    Peek at a big-endian I129.
    """
    peek_u128(rb, offset)?.i128()

  fun peek_f32(rb: PeekableReader box, offset: USize = 0): F32 ? =>
    """
    Peek at a big-endian F32.
    """
    F32.from_bits(peek_u32(rb, offset)?)

  fun peek_f64(rb: PeekableReader box, offset: USize = 0): F64 ? =>
    """
    Peek at a big-endian F64.
    """
    F64.from_bits(peek_u64(rb, offset)?)
